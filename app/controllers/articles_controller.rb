class ArticlesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def show
        @article = Article.find(params[:id])
        @comments = @article.comments.order('created_at DESC').paginate(page: params[:page], per_page: 5)
        @user = User.find(@article.user_id)
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = current_session_user.articles.build(article_params)
        if @article.save
            params[:article][:tag_list].each do |tag_name|
                unless tag_name.empty?
                    @article.attach_tag(Tag.find_by_name(tag_name))
                end
            end
            if @article.tags.empty?
                @article.attach_tag(Tag.find_by_name('general'))
            end
            flash[:success] = 'Your article has been created.'
            redirect_to root_url
        else
            render :new
        end
    end

    def update
        if @article.update_attributes(article_params)
            flash[:success] = 'Your article has been updated.'
            redirect_to @article
        else
            render :edit
        end
    end

    def destroy
        @article.destroy
        flash[:success] = 'Your article has been deleted.'
        redirect_to user_path(@article.user) || root_url
    end

    def search
        @keyword = params[:keyword]
        @articles = Article.search(params)
    end


    private
    def article_params
        params.require(:article).permit(:title, :content, :picture, :tag_list)
    end

    def correct_user
        @article = current_session_user.articles.find_by(id: params[:id])
        redirect_to root_url if @article.nil?
    end
end