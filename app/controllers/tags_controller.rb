class TagsController < ApplicationController
    before_action :logged_in_user, only: [:index, :show]

    def index
        @tags = Tag.all.order('name ASC')
    end

    def show
        @tag = Tag.friendly.find(params[:id])
        @articles = @tag.articles.paginate(page: params[:page], per_page: 15)
    end


    private
    def tag_params
        params.require(:tag).permit(:name)
    end
end
