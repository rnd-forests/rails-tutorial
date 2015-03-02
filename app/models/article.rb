class Article < ActiveRecord::Base

    default_scope -> { order(created_at: :desc) }
    mount_uploader :picture, PictureUploader
    validates :user_id, presence: true
    validates :title, presence: true
    validates :content, presence: true, length: { maximum: 5000 }
    validate :picture_size

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :article_tag_relationships, dependent: :destroy
    has_many :tags, through: :article_tag_relationships

    def attach_tag(tag)
        article_tag_relationships.create!(tag_id: tag.id)
    end

    def attaching_tag?(tag)
        tags.include?(tag)
    end

    def tag_list
        self.tags
    end

    def self.search(params)
        where('LOWER(title) LIKE ?', "%#{params[:keyword].downcase.strip}%").paginate(page: params[:page], per_page: 5)
    end

    def comment_authors
        user_ids = "SELECT user_id FROM comments WHERE article_id = #{self.id} GROUP BY user_id"
        User.where("id IN (#{user_ids})")
    end

    def to_param
        "#{id}-#{title.parameterize}"
    end


    private
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, 'should be less than 5MB')
        end
    end
end
