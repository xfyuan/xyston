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
  end
end