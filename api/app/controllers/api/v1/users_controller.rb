class Api::V1::UsersController < ApplicationController

    def show_current_user
      # NOTE:未認証であれば401エラーを返却する。
      unless current_user
        return head :unauthorized
      end
    
      user_data = current_user.attributes
      user_data[:icon_url] = rails_blob_url(current_user.icon) if current_user.icon.attached?
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
    
    private
    def user_params
        params.require(:user).permit(:name, :email, :profile_text, :icon)
    end
end