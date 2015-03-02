class Comment < ActiveRecord::Base

    validates :user_id, presence: true
    validates :article_id, presence: true
    validates :body, presence: true, length: { maximum: 1000 }

    belongs_to :user
    belongs_to :article

    def comment_author
        User.find(self.user_id)
    end
end
