require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validation" do
    let(:order) { build :order }

    it { should respond_to :total }
    it { should respond_to :user_id }

    it { should validate_presence_of :user_id }

    it { should belong_to :user }

    it { should have_many :placements }
    it { should have_many(:products).through(:placements) }
  end

  describe "#set_total!" do
    let(:product1) { create :product, price: 100 }
    let(:product2) { create :product, price: 85 }
    let(:order) { build :order, product_ids: [product1.id, product2.id] }

    it "returns total amount to pay for products" do
      expect { order.set_total! }.to change{ order.total }.from(0).to(185)
    end
  end

  describe "#build_placements_with_product_ids_and_quantities" do
    let(:product1) { create :product, price: 100, quantity: 5 }
    let(:product2) { create :product, price: 85, quantity: 10 }
    let(:order)    { build :order }
    let(:product_ids_and_quantities) { [ [product1.id, 2], [product2.id, 3] ] }

    it "builds 2 placements for the order" do
      expect { order.build_placements_with_product_ids_and_quantities(product_ids_and_quantities) }.to change{ order.placements.size }.from(0).to(2)
    end
  end

  describe "#valid?" do
    let(:product1) { create :product, price: 100, quantity: 5 }
    let(:product2) { create :product, price: 85, quantity: 10 }

    let(:placement1) { create :placement, product: product1, quantity: 3 }
    let(:placement2) { create :placement, product: product2, quantity: 12 }

    let(:order)    { build :order }

    before do
      order.placements << placement1
      order.placements << placement2
    end

    it "is invalid due to insufficient products" do
      expect(order).not_to be_valid
    end
  end
end
