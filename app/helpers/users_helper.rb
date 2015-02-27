module UsersHelper

    def user_gravatar(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name)
    end

    def top_creators
        User.joins(:articles).select('users.*, count(user_id) AS article_count')
            .group('users.id')
            .order('article_count DESC')
            .limit(10)
    end

    def top_followers
        User.select('users.*, COUNT(*) AS follower_count')
            .joins('INNER JOIN relationships ON relationships.followed_id = users.id')
            .group('relationships.followed_id')
            .order('follower_count DESC')
            .limit(5)
    end
end
