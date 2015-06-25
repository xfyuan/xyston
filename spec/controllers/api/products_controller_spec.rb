require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do

  describe "GET #index" do
    let(:user) { create :user }
    before do
      3.times { create :product, user: user }
      get :index
    end

    it { should respond_with 200 }

    it "assigns all products as @products" do
      expect(json_response[:products].count).to eq 3
      expect(assigns(:products).count).to eq 3
    end
  end

  describe "GET #show" do
    let(:product) { create :product }

    before { get :show, id: product.to_param }

    it { should respond_with 200 }

    it "assigns the requested product as @product" do
      expect(assigns(:product)).to eq product
      expect(json_response[:title]).to eq product.title
    end
  end
end
