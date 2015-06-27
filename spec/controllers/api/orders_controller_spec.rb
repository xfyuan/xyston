require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do

  let(:current_user) { create :user }
  before do
    api_authorization_header current_user.authentication_token
  end

  describe "GET #index" do
    before do
      4.times { create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it { should respond_with 200 }

    it "return product as @products" do
      expect(json_response[:orders].count).to eq 4
    end

    it_behaves_like "paginated list"
  end

  describe "GET #show" do
    let(:product) { create :product }
    let(:order) { create :order, user: current_user, product_ids: [product.id] }

    before do
      get :show, user_id: current_user.id, id: order.id
    end

    it { should respond_with 200 }

    it "returns the user order matching the id" do
      expect(json_response[:order][:id]).to eq order.id
    end

    it "includes the total for the order" do
      expect(json_response[:order][:total]).to eq order.total.to_s
    end

    it "includes the products on the order" do
      expect(json_response[:order][:products].count).to eq 1
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:product1) { create :product }
      let(:product2) { create :product }
      let(:order_params) { { product_ids_and_quantities: [[product1.id, 2], [product2.id, 3]] } }

      before do
        post :create, { user_id: current_user.id, order: order_params }
      end

      it { should respond_with 201 }

      it "renders just the user order" do
        expect(json_response).to be_a(Hash)
        expect(json_response[:order][:id]).to be_present
      end

      it "embed the 2 products objects related to the order" do
        expect(json_response[:order][:products].size).to eq 2
      end
    end
  end
end
