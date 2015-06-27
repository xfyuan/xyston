class Product < ActiveRecord::Base
  validates_presence_of :title, :price, :user_id
  validates_numericality_of :price, greater_than_or_equal_to: 0

  belongs_to :user

  scope :recent,                  -> { order(updated_at: :desc) }
  scope :filter_by_title,         ->(keyword) { where("lower(title) LIKE ?", "%#{keyword.downcase}%") }
  scope :above_or_equal_to_price, ->(price) { where("price >= ?", price) }
  scope :below_or_equal_to_price, ->(price) { where("price <= ?", price) }
end
