class Api::V1::PostsController < ApplicationController
    before_action :set_post, only:[:show, :edit, :update, :destroy]
    
    def index
        posts = Post.includes(:user, :tags)

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
            post_data
        end
        render json: posts_data
    end

    def create
        @post = current_user.posts.build(post_params.except(:tags))
            if @post.save
                #FIX:タグづけに失敗すると投稿の作成自体もロールバックさせるようにして整合性を取れるようにしたい
                update_tags(@post)
                render json: @post
            else
                render json: @post.errors, status: 422
            end
    end

    def show
        is_current_user_post_owner = current_user&.id == @post.user_id
        # current_userが@postに対していいねしているかどうかの判定
        is_liked = Like.exists?(user_id: current_user&.id, post_id: @post.id)

        render json: @post.as_json(methods: [:formatted_created_at, :formatted_updated_at]).merge(
            is_current_user_post_owner: is_current_user_post_owner,
            is_liked: is_liked
            )
    end

    def update
        if @post.update(post_params)
            render json: @post
        else
            render json: @post.erros, status: 422
        end
    end

    def destroy
        @post.destroy
    end

    # 自身の投稿のみを取得する
    def own_posts
        current_user_posts = current_user&.posts
        if current_user_posts&.any?
            render json: current_user_posts.as_json(methods: [:formatted_created_at, :formatted_updated_at])
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
            render json: user_liked_posts.as_json(methods: [:formatted_created_at, :formatted_updated_at])
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

    def update_tags(post)
        # タグの配列を受け取ります（リクエストから）
        tags = params[:post][:tags] 
    
        # タグを処理する
        tags.each do |tag_name|
          tag = Tag.find_or_create_by(tag_name: tag_name.strip)
          post.tags << tag unless post.tags.include?(tag)
        end
    end

    def append_user_icon_url(post, post_data)
        if post.user && post.user.icon.attached?
          post_data['user'] ||= {}
          post_data['user']['icon_url'] = rails_blob_url(post.user.icon)
        end
    end

end
