module UsersHelper

    def user_gravatar(user, options = { size: 80 })
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, class: 'user-avatar', alt: user.name)
    end

    def top_followed_users
        User.select(:id, :name)
            .joins('INNER JOIN relationships ON users.id = relationships.followed_id')
            .group('users.id')
            .order('COUNT(users.id) DESC')
            .limit(5)
    end

    def top_creators
        User.select(:id, :name)
            .joins(:articles)
            .group('users.id')
            .order('COUNT(users.id) DESC')
            .limit(10)
    end
end
