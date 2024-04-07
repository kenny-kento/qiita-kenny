class Api::V1::PostsController < ApplicationController
    before_action :set_post, only:[:show, :edit, :update, :destroy]
    
    def index
        posts = Post.includes(:user)
        render json: posts.as_json(include: { user: { only: [:id, :name, :image] } },methods: :formatted_created_at)
    end

    def create
        @post = current_user.posts.create(post_params)
            if @post.save
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
        liked_posts = Post.joins(:likes).where(likes: { user_id: current_user&.id })
        if liked_posts&.any?
            render json: liked_posts.as_json(methods: [:formatted_created_at, :formatted_updated_at])
        else
            render json: [], status: :not_found
        end
    end

    private 
    def post_params
        params.require(:post).permit(:title, :content,)
    end

    def set_post
        @post = Post.find(params[:id])
    end

end
