require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do

  let(:user) { create :user }

  describe "POST #create" do
    context "with valid params" do
      before do
        credentials = { email: user.email, password: user.password}
        post :create, { user: credentials }
      end

      it { should respond_with 200 }

      it "returns the user record to the given credentials" do
        user.reload
        expect(json_response[:token]).to eq user.authentication_token
      end
    end

    context "with invalid params" do
      before do
        credentials = { email: user.email, password: 'invalidepassword' }
        post :create, { user: credentials }
      end

      it { should respond_with 401 }

      it "assigns a newly created but unsaved api_session as @api_session" do
        expect(json_response[:errors]).to eq 'Invalid email or password'
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      credentials = { email: user.email, password: user.password}
      post :create, { user: credentials }
      user.reload
      @old_token = user.dup.authentication_token
      delete :destroy, { :id => @old_token }
    end

    it { should respond_with 204 }

    it "will use a new authentication_token next time" do
      user.reload
      expect(@old_token).not_to eq user.authentication_token
    end
  end

end
