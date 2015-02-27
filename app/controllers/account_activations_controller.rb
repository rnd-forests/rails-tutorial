class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.activate
            log_in user
            flash[:success] = 'Your account has been activated!'
            redirect_to user
        else
            flash[:danger] = 'Your activation link is invalid or expired!'
            redirect_to root_url
        end
    end
end
