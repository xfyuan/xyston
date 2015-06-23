require 'rails_helper'

class Authentication < ApplicationController
  include Authenticable
end

RSpec.describe Authenticable, type: :controller do
  let(:user) { create(:user) }
  let(:authentication) { Authentication.new }

  describe "#current_user" do
    before do
      request.headers['Authorization'] = user.authentication_token
      allow(authentication).to receive(:request) { request }
    end

    it "returns the uesr from then authorization header" do
      expect(authentication.current_user.authentication_token).to eq user.authentication_token
    end
  end
end
