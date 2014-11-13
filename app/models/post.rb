class Post < ActiveRecord::Base
  validates :title, length: { maximum: 255 }, presence: true
  validates :link, presence: true, if: :link?
  validates :link, length: { maximum: 2000 }
  validates :body, presence: true, if: :text?
  validates :category_id, presence: true
  enum post_type: [:link, :text]

  belongs_to :category
  belongs_to :user
  default_scope { order('updated_at DESC') }
  scope :with_categories, -> { includes(:category) }
  scope :with_user,       -> { includes(:user)     }

  self.per_page = 5
end
