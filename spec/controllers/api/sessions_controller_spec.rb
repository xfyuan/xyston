require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Api::Session. As you add validations to Api::Session, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:user)
  }

  let(:invalid_attributes) {
  }

  describe "POST #create" do
    let!(:user) { User.create! valid_attributes }

    context "with valid params" do
      before do
        credentials = { email: valid_attributes[:email], password: valid_attributes[:password]}
        post :create, { user: credentials }
      end

      it "returns the user record to the given credentials" do
        user.reload
        expect(json_response[:token]).to eq user.authentication_token
      end

      it { should respond_with 200 }
    end

    context "with invalid params" do
      before do
        credentials = { email: valid_attributes[:email], password: 'invalidepassword' }
        post :create, { user: credentials }
      end

      it "assigns a newly created but unsaved api_session as @api_session" do
        expect(json_response[:errors]).to eq 'Invalid email or password'
      end

      it { should respond_with 401 }
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested api_session" do
      session = Api::Session.create! valid_attributes
      expect {
        delete :destroy, {:id => session.to_param}
      }.to change(Api::Session, :count).by(-1)
    end

    it "redirects to the api_sessions list" do
      session = Api::Session.create! valid_attributes
      delete :destroy, {:id => session.to_param}
      expect(response).to redirect_to(api_sessions_url)
    end
  end

end
