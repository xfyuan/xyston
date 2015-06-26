require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  let(:valid_attributes)         { attributes_for(:user) }
  let(:valid_attributes_another) { attributes_for(:user, name:'another', email:'another@abc.com') }
  let(:invalid_attributes)       { attributes_for(:user, name: nil) }

  describe "GET #index" do
    let!(:user) { create :user }

    before do
      get :index
    end

    it { should respond_with 200 }

    it "assigns all users as @users" do
      expect(assigns(:users)).to eq [user]
    end
  end

  describe "GET #show" do
    let(:user) { create :user }

    before do
      get :show, id: user.id
    end

    it { should respond_with 200 }

    it "assigns the requested user as @user" do
      expect(assigns(:user)).to eq user
    end

    it "has products ids as embed object" do
      expect(json_response[:user][:product_ids]).to eq []
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before { post :create, {:user => valid_attributes} }

      it { should respond_with 201 }

      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes_another}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "renders the json response for user created" do
        expect(json_response).to be_a(Hash)
        expect(json_response[:user][:email]).to eq(valid_attributes[:email])
        expect(assigns(:user)[:email]).to eq(valid_attributes[:email])
      end
    end

    context "with invalid params" do
      before { post :create, {:user => invalid_attributes} }

      it { should respond_with 422 }

      it "assigns a newly created but unsaved user as @user" do
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
        expect(json_response[:errors][:name]).to include "can't be blank"
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { attributes_for(:user, name: 'updated user') }
      let(:user) { user = User.create! valid_attributes }

      before do
        api_authorization_header user.authentication_token
        put :update, {:id => user.to_param, :user => valid_attributes}
      end

      it { should respond_with 200 }

      it "renders the json response for user updated" do
        put :update, {:id => user.to_param, :user => new_attributes}
        user.reload

        expect(json_response).to be_a(Hash)
        expect(json_response[:user][:name]).to eq(new_attributes[:name])
      end

      it "assigns the requested user as @user" do
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with invalid params" do
      let(:user) { user = User.create! valid_attributes }

      before do
        api_authorization_header user.authentication_token
        put :update, {:id => user.to_param, :user => invalid_attributes}
      end

      it { should respond_with 422 }

      it "assigns the user as @user" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
        expect(json_response[:errors][:name]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { user = User.create! valid_attributes }
    let(:request_delete) { delete :destroy, {:id => user.to_param} }

    before { api_authorization_header user.authentication_token }

    it "responds with status 204" do
      request_delete
      should respond_with 204
    end

    it "destroys the requested user" do
      expect { request_delete }.to change(User, :count).by(-1)
    end
  end

end
