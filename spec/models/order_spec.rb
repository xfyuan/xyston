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
    let(:user) { create :user }
    let(:product1) { create :product, price: 100 }
    let(:product2) { create :product, price: 85 }
    let(:order) { build :order, user: user, product_ids: [product1.id, product2.id] }

    it "returns total amount to pay for products" do
      expect { order.set_total! }.to change{ order.total }.from(0).to(185)
    end
  end
end
