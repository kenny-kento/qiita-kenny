class Api::V1::UsersController < ApplicationController

    def show_current_user
      # NOTE:未認証であれば401エラーを返却する。
      return head :unauthorized unless current_user
      
      user_data = current_user.attributes

      # HACK:　将来的にposts_countとreceived_likes_countにcounter_cacheを利用したパフォーマンス改善を検討
      user_data.merge!({
        icon_url: current_user.icon.attached? ? rails_blob_url(current_user.icon) : nil,
        posts_count: current_user.posts.count,
        received_likes_count: current_user.posts.joins(:likes).count
       })

      render json: user_data
    end
    
    def update
        begin
          if current_user.update(user_params)
            render json: current_user
          else
            render json: { error: '更新に失敗しました' }, status: 422
          end
        rescue StandardError => e
          render json: { error: 'サーバーエラーが発生しました' }, status: 500
        end
    end

    def likers
      liked_users = User.joins(:likes).where(likes: {post_id: params[:id]})
      
      modified_users = liked_users.map do |liked_user|
        user_data = liked_user.attributes
        user_data.merge!({
          icon_url: liked_user.icon.attached? ? rails_blob_url(liked_user.icon) : nil
        })
        user_data
      end

      render json: modified_users
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :profile_text, :icon)
    end
end