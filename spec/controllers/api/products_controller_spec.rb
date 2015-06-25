require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do

  let(:valid_attributes)   { attributes_for(:product) }
  let(:valid_attributes_another) { attributes_for(:product, title:'another') }
  let(:invalid_attributes) { attributes_for(:product, title: nil) }

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

    it "returns user object into each products" do
      json_response[:products].each do |product|
        expect(product[:user]).to be_present
      end
    end
  end

  describe "GET #show" do
    let(:product) { create :product }

    before { get :show, id: product.to_param }

    it { should respond_with 200 }

    it "assigns the requested product as @product" do
      expect(assigns(:product)).to eq product
      expect(json_response[:product][:title]).to eq product.title
    end

    it "has user as embeded object" do
      expect(json_response[:product][:user][:email]).to eq product.user.email
    end
  end

  describe "POST #create" do
    let(:user) { create :user }

    context "with valid params" do
      before do
        api_authorization_header user.authentication_token
        post :create, { user_id: user.id, product: valid_attributes }
      end

      it { should respond_with 201 }

      it "creates a new Product" do
        expect {
          post :create, { user_id: user.id, product: valid_attributes_another }
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "renders the json response for product created" do
        expect(json_response).to be_a(Hash)
        expect(json_response[:product][:title]).to eq(valid_attributes[:title])
        expect(assigns(:product)[:title]).to eq(valid_attributes[:title])
      end
    end

    context "with invalid params" do
      before do
        api_authorization_header user.authentication_token
        post :create, { user_id: user.id, product: invalid_attributes }
      end

      it { should respond_with 422 }

      it "assigns a newly created but unsaved product as @product" do
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
        expect(json_response[:errors][:title]).to include "can't be blank"
      end
    end
  end

  describe "PUT #update" do
    let(:user) { create :user }
    let(:product) { create :product, user: user }

    before { api_authorization_header user.authentication_token }

    context "with valid params" do
      let(:new_attributes) { attributes_for(:product, title: 'updated product') }

      before do
        put :update, { user_id: user.id, id: product.id, product: new_attributes }
      end

      it { should respond_with 200 }

      it "renders the json response for product updated" do
        expect(json_response).to be_a(Hash)
        expect(json_response[:product][:title]).to eq(new_attributes[:title])
      end

      it "assigns the requested product as @product" do
        expect(assigns(:product)).to eq(product)
      end
    end

    context "with invalid params" do
      before do
        put :update, { user_id: user.id, id: product.id, product: invalid_attributes }
      end

      it { should respond_with 422 }

      it "assigns the product as @product" do
        expect(assigns(:product)).to eq(product)
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
        expect(json_response[:errors][:title]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create :user }
    let!(:product) { create :product, user: user }
    let(:request_delete) { delete :destroy, { user_id: user.id, id: product.id } }

    before { api_authorization_header user.authentication_token }

    it "responds with status 204" do
      request_delete
      should respond_with 204
    end

    it "destroys the requested product" do
      expect { request_delete }.to change(Product, :count).by(-1)
    end
  end
end
