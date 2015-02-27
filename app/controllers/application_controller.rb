class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    private
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = 'This action is restricted for authenticated user only. Please log in to continue.'
            redirect_to signin_url
        end
    end
end
