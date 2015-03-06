class CommentsController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user, only: :destroy

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = @current_user.id
        respond_to do |format|
            if @comment.save
                format.html { redirect_to request.referer }
                format.js
            else
                format.html { redirect_to request.referer, flash: { danger: 'Your comment was discarded.' } }
                format.js { render js: "$('#failed-comment-modal').modal('show');" }
            end
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            respond_to do |format|
                format.html { redirect_to request.referer }
                format.js do
                    render js: "$('#deleted-comment-modal').modal('show');"
                end
            end
        end
    end


    private
    def comment_params
        params.require(:comment).permit(:article_id, :user_id, :body)
    end
end
