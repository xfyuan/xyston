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

  describe "GET #show" do
    let(:order) { create :order, user: current_user }

    before do
      get :show, user_id: current_user.id, id: order.id
    end

    it { should respond_with 200 }

    it "returns the user order matching the id" do
      expect(json_response[:order][:id]).to eq order.id
    end
  end
end
