class Order < ActiveRecord::Base
  validates_presence_of :total, :user_id
  validates_numericality_of :total, greater_than_or_equal_to: 0

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

end
