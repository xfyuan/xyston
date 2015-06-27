class Order < ActiveRecord::Base
  validates_presence_of :total, :user_id
  validates_numericality_of :total, greater_than_or_equal_to: 0

  before_validation :set_total!

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  def set_total!
    self.total = products.map(&:price).sum
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantities|
      id, quantity = product_id_and_quantities
      self.placements.build(product_id: id)
    end
  end

end
