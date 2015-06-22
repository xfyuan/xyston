require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:user)
  }

  let(:invalid_attributes) {
    attributes_for(:user, name: nil)
  }

  describe "GET #index" do
    let!(:user) { User.create! valid_attributes }

    before { get :index, {}, format: :json }

    it { should respond_with 200 }

    it "assigns all users as @users" do
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET #show" do
    let(:user) { User.create! valid_attributes }

    before { get :show, {:id => user.to_param}, format: :json }

    it { should respond_with 200 }

    it "assigns the requested user as @user" do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before { post :create, {:user => valid_attributes}, format: :json }

      it { should respond_with 201 }

      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, format: :json
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "renders the json response for user created" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to be_a(Hash)
        expect(json[:user][:email]).to eq(valid_attributes[:email])
        expect(assigns(:user)[:email]).to eq(valid_attributes[:email])
      end
    end

    context "with invalid params" do
      before { post :create, {:user => invalid_attributes}, format: :json }

      it { should respond_with 422 }

      it "assigns a newly created but unsaved user as @user" do
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders an errors json" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to have_key(:errors)
        expect(json[:errors][:name]).to include "can't be blank"
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => new_attributes}, format: :json
        user.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, format: :json
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, format: :json
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => invalid_attributes}, format: :json
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => invalid_attributes}, format: :json
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}, format: :json
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete :destroy, {:id => user.to_param}, format: :json
      expect(response).to redirect_to(users_url)
    end
  end

end
