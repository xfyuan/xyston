require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do

  let(:user)                     { create :user }
  let(:valid_attributes)         { attributes_for(:product) }
  let(:valid_attributes_another) { attributes_for(:product, title:'another') }
  let(:invalid_attributes)       { attributes_for(:product, title: nil) }

  describe "GET #index" do
    before do
      4.times { create :product, user: user }
    end

    context "without any product_ids params" do
      before do
        get :index
      end

      it { should respond_with 200 }

      it "return product as @products" do
        expect(json_response[:products].count).to eq 4
        expect(assigns(:products).count).to eq 4
      end

      it "returns the user object into each product" do
        json_response[:products].each do |product_response|
          expect(product_response[:user]).to be_present
        end
      end
    end


    context "with product_ids params" do
      let(:second_user) { create :user, name: 'second_user', email: 'second_user@abc.com' }
      before do
        3.times { create :product, user: second_user }
        get :index, product_ids: second_user.product_ids
      end

      it "returns products just belongs to the second user" do
        expect(json_response[:products].count).to eq 3
        json_response[:products].each do |product_response|
          expect(product_response[:user][:email]).to eq second_user.email
        end
      end
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

    it "has the user as embed object" do
      expect(json_response[:product][:user][:email]).to eq user.email
    end
  end

  describe "POST #create" do
    before do
      api_authorization_header user.authentication_token
    end

    context "with valid params" do
      before do
        post :create, {user_id: user.id, product: valid_attributes}
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
        expect(json_response[:product][:title]).to eq valid_attributes[:title]
        expect(assigns(:product)[:title]).to eq valid_attributes[:title]
      end
    end

    context "with invalid params" do
      before do
        post :create, {user_id: user.id, product: invalid_attributes}
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
    let(:product) { create :product, user: user }
    before do
      api_authorization_header user.authentication_token
    end

    context "with valid params" do
      let(:new_attributes) { attributes_for(:product, title: 'updated product') }

      before do
        put :update, { user_id: user.id, id: product.id, product: new_attributes }
      end

      it { should respond_with 200 }

      it "renders the json response for product updated" do
        expect(json_response).to be_a(Hash)
        expect(json_response[:product][:title]).to eq new_attributes[:title]
      end

      it "assigns the requested product as @product" do
        expect(assigns(:product)).to eq product
      end
    end

    context "with invalid params" do
      before do
        put :update, { user_id: user.id, id: product.id, product: invalid_attributes }
      end

      it { should respond_with 422 }

      it "assigns the product as @product" do
        expect(assigns(:product)).to eq product
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
        expect(json_response[:errors][:title]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
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
