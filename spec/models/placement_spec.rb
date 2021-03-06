require 'rails_helper'

RSpec.describe Placement, type: :model do
  let(:placement) { build :placement }

  describe "validation" do

    it { should respond_to :order_id }
    it { should respond_to :product_id }
    it { should respond_to :quantity }

    it { should belong_to :order }
    it { should belong_to :product }
  end

  describe "#decrement_product_quantity!" do
    it "decreases the product quantity by the placement quantity" do
      expect { placement.decrement_product_quantity! }.to change{ placement.product.quantity }.by(-placement.quantity)
    end
  end
end
