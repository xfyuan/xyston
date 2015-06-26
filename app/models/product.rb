class Product < ActiveRecord::Base
  validates_presence_of :title, :price, :user_id
  validates_numericality_of :price, greater_than_or_equal_to: 0

  belongs_to :user
end
