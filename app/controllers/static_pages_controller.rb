class StaticPagesController < ApplicationController
	def home
        if logged_in?
            @article = current_session_user.articles.build
            @feed_items = current_session_user.feed.paginate(page: params[:page], per_page: 20)
        end
    end

	def about
    end

    def contact
    end
end
