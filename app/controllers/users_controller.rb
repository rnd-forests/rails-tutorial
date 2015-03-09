class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user, only: :destroy

    def index
        @users = User.order('name').paginate(page: params[:page], per_page: 30)
    end

    def show
        @user = User.find(params[:id])
        unless @user.nil?
            @user_articles = Article.where(user_id: @user.id).paginate(page: params[:page], per_page: 5)
        end
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            flash[:info] = 'Please check your email address to activate your account.'
            redirect_to root_url
        else
            render :new
        end
    end

    def update
        if @user.update_attributes(user_params)
            flash[:success] = 'Your profile has been successfully updated.'
            redirect_to @user
        else
            render :edit
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = 'Account has been deactivated.'
        redirect_to users_url
    end

    def following
        @title = 'Following'
        @user  = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page], per_page: 18)
        render :show_follow
    end

    def followers
        @title = 'Followers'
        @user  = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page], per_page: 18)
        render :show_follow
    end

    def articles
        @user = User.find(params[:id])
        @articles = @user.articles
    end

    def activities
        @user = User.find(params[:id])
        @relationships = Relationship.where(follower_id: @user.id).order('created_at DESC').paginate(page: params[:page], per_page: 15)
        @comments = @user.comments.order('created_at DESC').paginate(page: params[:page], per_page: 15)
        @articles = @user.articles.paginate(page: params[:page], per_page: 15)
    end


    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end
end
