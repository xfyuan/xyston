require 'rails_helper'

class Authentication < ApplicationController
  include Authenticable
end

RSpec.describe Authenticable, type: :controller do
  let(:user) { create(:user) }
  let(:authentication) { Authentication.new }

  subject { authentication }

  describe "#current_user" do
    before do
      request.headers['Authorization'] = user.authentication_token
      allow(authentication).to receive(:request) { request }
    end

    it "returns the uesr from then authorization header" do
      expect(authentication.current_user.authentication_token).to eq user.authentication_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      allow(authentication).to receive(:current_user) { nil }
      allow(authentication).to receive(:response) { response }
      allow(response).to receive(:response_code) { 401 }
      allow(response).to receive(:body) { {"errors" => "Not authenticated"}.to_json }
    end

    it { should respond_with 401 }

    it "render a json error" do
      expect(json_response[:errors]).to eq 'Not authenticated'
    end
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        allow(authentication).to receive(:current_user) { user }
      end

      it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      before do
        allow(authentication).to receive(:current_user) { nil }
      end

      it { should_not be_user_signed_in }
    end
  end
end
