class CommentsController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user, only: :destroy

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = @current_user.id
        if @comment.save
            redirect_to request.referer
        else
            flash[:danger] = 'Something probably went wrong. Your comment was discarded.'
            redirect_to request.referer
        end
    end

    def destroy
        Comment.find(params[:id]).destroy
        flash[:success] = 'Your comment has been deleted!'
        redirect_to request.referer
    end


    private
    def comment_params
        params.require(:comment).permit(:article_id, :user_id, :body)
    end
end
