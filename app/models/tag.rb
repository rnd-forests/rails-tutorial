class Tag < ActiveRecord::Base

    include FriendlyId
    friendly_id :name, use: :finders

    validates :name, presence: true

    has_many :article_tag_relationships, dependent: :destroy
    has_many :articles, through: :article_tag_relationships

    def attach_article(article)
        article_tag_relationships.create!(article_id: article.id)
    end

    def attaching_article?(article)
        articles.include?(article)
    end
end
