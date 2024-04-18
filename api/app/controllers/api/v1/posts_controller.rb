class Api::V1::PostsController < ApplicationController
    before_action :set_post, only:[:show, :edit, :update, :destroy]
    
    def index
        posts = Post.includes(:user, :tags, :likes)

        posts_data = posts.map do |post|
            post_data = post.as_json(
              include: {
                user: { only: [:id, :name, :image] },
                tags: { only: [:tag_name] } 
              },
              methods: :formatted_created_at
            )
            # ユーザーのアイコンURLを取得してpost_dataに含める
            append_user_icon_url(post, post_data)
            post_data[:likes_count] = post.likes.size
            post_data
        end
        render json: posts_data
    end

    def create
        ActiveRecord::Base.transaction do
            @post = current_user.posts.build(post_params.except(:tags))
            if @post.save
                # タグがある場合はタグづけ処理を行う
                create_tags(@post) unless params[:post][:tags].blank?
    
                render json: @post
            else
                render json: @post.errors, status: :unprocessable_entity
                raise ActiveRecord::Rollback
            end
        end
        rescue => e
        #NOTE:タグづけに失敗した時は投稿の保存自体もロールバックさせる。
        render json: { error: "投稿とタグ付けの処理に失敗しました: #{e.message}" }, status: :internal_server_error
    end
    
    def show
        is_current_user_post_owner = current_user&.id == @post.user_id
        # current_userが@postに対していいねしているかどうかの判定
        is_liked = Like.exists?(user_id: current_user&.id, post_id: @post.id)

        render json: @post.as_json(
            methods: [:formatted_created_at, :formatted_updated_at],
            include: { tags: { only: [:tag_name] } }
        ).merge(
            is_current_user_post_owner: is_current_user_post_owner,
            is_liked: is_liked
        )
    end

    def update
        ActiveRecord::Base.transaction do
            if @post.update(post_params.except(:tags))
                update_tags(@post) unless params[:post][:tags].blank?
                render json: @post
            else
                render json: @post.errors, status: :unprocessable_entity
                raise ActiveRecord::Rollback
            end
        end
        rescue => e
        #NOTE:タグづけに失敗した時は投稿の保存自体もロールバックさせる。
            render json: { error: "投稿の更新またはタグの更新に失敗しました。: #{e.message}" }, status: :internal_server_error
    end

    def destroy
        @post.destroy
    end

    # 自身の投稿のみを取得する
    def own_posts
        current_user_posts = current_user&.posts
        if current_user_posts&.any?
            render json: current_user_posts.as_json(
                methods: [:formatted_created_at, :formatted_updated_at],
                include: { tags: { only: [:tag_name] } }
                )
        else
            render json: [], status: :not_found
        end
    end

    # NOTE:アーキテクチャ変更や機能が複雑化し複数のモデル間での検索機能として独立させたい場合は別途コントローラーを切り出す予定
    def search
        searched_posts = if params[:keyword].present?
                            Post.where('title LIKE ?', "%" + Post.sanitize_sql_like(params[:keyword]) + "%")
                         else  
                            Post.all
                         end
        
        searched_posts = searched_posts.includes(:user)
        render json: searched_posts.as_json(include: { user: { only: [:id, :name, :image] } },methods: :formatted_created_at)
    end

    def liked_posts
        user_liked_posts = Post.joins(:likes).where(likes: { user_id: current_user&.id })
        if user_liked_posts.any?
            render json: user_liked_posts.as_json(
                methods: [:formatted_created_at, :formatted_updated_at],
                include: { tags: { only: [:tag_name] } }
                )
        else
            render json: []
        end
    end

    private 
    def post_params
        params.require(:post).permit(:title, :content, tags: [])
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def create_tags(post)
        tags = params[:post][:tags].map(&:strip).uniq

        add_tags(tags, post)
    rescue ActiveRecord::RecordInvalid => e
        raise ActiveRecord::Rollback, "タグの作成/関連付けに失敗しました: #{e.message}"
    end    

    def update_tags(post)
        # NOTE:現状のタグと更新で渡ってきたタグを整理する
        new_tags = params[:post][:tags].map(&:strip)
        old_tags = post.tags.pluck(:tag_name)
      
        # NOTE:追加されるタグ、削除するタグを洗い出す。
        tags_to_add = new_tags - old_tags
        tags_to_remove = old_tags - new_tags
      
        # 追加されるべきタグを追加
        add_tags(tags_to_add, post)
        # 削除されるべきタグを削除
        tags_to_remove.each do |tag_name|
          tag = Tag.find_by(tag_name: tag_name)
          post.tags.delete(tag) if tag
        end
    rescue ActiveRecord::RecordInvalid => e
        raise ActiveRecord::Rollback, "タグの更新/関連付けに失敗しました: #{e.message}"
    end      

    def append_user_icon_url(post, post_data)
        if post.user && post.user.icon.attached?
          post_data['user'] ||= {}
          post_data['user']['icon_url'] = rails_blob_url(post.user.icon)
        end
    end

    def add_tags(tags, post)
        # NOTE:tagsに含まれるタグを一括で検索した上で存在しないタグは作成する。
        existing_tags = Tag.where(tag_name: tags).index_by(&:tag_name)
        
        tags.each do |tag_name|
            tag = existing_tags[tag_name] || Tag.create(tag_name: tag_name)
            #NOTE:紐付けがされていないタグの紐付けを行う。
            post.tags << tag unless post.tags.exists?(tag_name: tag_name)
        end
    end

end