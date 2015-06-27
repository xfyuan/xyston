require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build :product }

  describe "validations" do
    it { should respond_to :title }
    it { should respond_to :price }
    it { should respond_to :published }
    it { should respond_to :user_id }

    it { should_not be_published }

    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :user_id }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    it { should belong_to :user }

    it { should have_many :placements }
    it { should have_many(:orders).through(:placements) }
  end

  describe "scope for search" do
    let(:user) { create :user }
    let!(:product1) { create :product, title: 'Apple TV', price: 100, user: user }
    let!(:product2) { create :product, title: 'Fastest Laptop', price: 50, user: user }
    let!(:product3) { create :product, title: 'CD Player', price: 150, user: user }
    let!(:product4) { create :product, title: 'LCD TV', price: 99, user: user }

    context ".filter_by_title: when a 'TV' title pattern is sent" do
      it "returns 2 products matching" do
        expect(Product.filter_by_title('TV').count).to eq 2
      end

      it "returns products matching" do
        expect(Product.filter_by_title('TV').sort).to eq [product1, product4]
      end
    end

    context ".above_or_equal_to_price and .below_or_equal_to_price" do
      it "returns products which are above or equal to the price" do
        expect(Product.above_or_equal_to_price(100).sort).to eq [product1, product3]
      end

      it "returns products which are below or equal to the price" do
        expect(Product.below_or_equal_to_price(99).sort).to eq [product2, product4]
      end
    end

    context ".recent" do
      before do
        product2.touch
        product3.touch
      end

      it "returns the most updated records" do
        expect(Product.recent).to eq [product3, product2, product4, product1]
      end
    end

    context ".search" do
      it "returns empty array when title 'fastest' and '100' a min price are set" do
        search_hash = { keyword: 'fastest', min_price: 100 }
        expect(Product.search(search_hash)).to be_empty
      end

      it "returns product1 when title 'tv', '150' as max price, and '100' as min price are set" do
        search_hash = { keyword: 'tv', min_price: 100, max_price: 150 }
        expect(Product.search(search_hash)).to eq [product1]
      end

      it "returns all products when empty hash is sent" do
        expect(Product.search({})).to eq [product1, product2, product3, product4]
      end

      it "returns product from the ids when product_ids is present" do
        search_hash = { product_ids: [product1.id, product2.id] }
        expect(Product.search(search_hash)).to eq [product1, product2]
      end
    end
  end

end
