class Api::V1::LikesController < ApplicationController

    def create
        @like = current_user.likes.build(like_params)
            if  @like.save
                render json: @like
            else
                render json: @like.errors, status: 422
            end
    end

    def destroy
        @like = Like.find_by(user_id: current_user&.id, post_id:params[:id])
        @like.destroy
    end

    private 
    def like_params
        params.require(:like).permit(:post_id)
    end

end
