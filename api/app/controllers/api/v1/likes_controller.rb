class Api::V1::LikesController < ApplicationController

    def create
        @like = current_user.likes.build(like_params)
            if  @like.save
                render json: @like, status: :created
            else
                render json: @like.errors, status: :unprocessable_entity
            end
    end

    def destroy
        # NOTE: 保守性を考慮してdestoy_byではなくfind_byとdestoryを組み合わせる
        @like = Like.find_by(user_id: current_user&.id, post_id: params[:id])
        if @like
            @like.destroy
            head :no_content
        else
            head :not_found
        end
    end

    private 
    def like_params
        params.require(:like).permit(:post_id)
    end

end
