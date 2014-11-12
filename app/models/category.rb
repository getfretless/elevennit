class Category < ActiveRecord::Base
  validates :name, length: { maximum: 20 }, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :sidebar, length: { maximum: 5120 }
  validates :submission_text, length: { maximum: 1024 }

  has_many :posts
  default_scope { order('lower(name) ASC') }
  scope :added_lately, -> { where('created_at > ?', 1.hour.ago) }
  scope :redundant_find, -> (id) { where(id: id) }
  scope :added_after, -> (time) { where('created_at > ?', time) }

  scope :lambda_find, lambda { |id| where(id: id) }
  scope :proc_find, Proc.new { |id| where(id: id) }

  scope :named, -> (name) do
    where(name: name)
  end
end

# class User
#   scope :active, -> { where(active: true) }
#   scope :admin, -> { where(user_type: 'admin') }
# end
#
#
#
# # These two are equivalent
# -> (id) { where(id: id) }
# lambda { |id| where(id: id) }
#
# # This one will not raise an exception if you fail to pass an id
# Proc.new { |id| where(id: id) }
#
# def method(arg1)
