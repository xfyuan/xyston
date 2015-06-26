require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do

  let(:user) { create :user }

  describe "GET #index" do
    before do
      4.times { create :product, user: user }
      get :index
    end

    it { should respond_with 200 }

    it "return product as @products" do
      expect(json_response[:products].count).to eq 4
      expect(assigns(:products).count).to eq 4
    end
  end

  describe "GET #show" do
    let(:product) { create :product, user: user }

    before do
      get :show, id: product.id
    end

    it { should respond_with 200 }

    it "assigns the requested product as @product" do
      expect(json_response[:product][:title]).to eq product.title
      expect(assigns(:product)).to eq product
    end
  end
end
