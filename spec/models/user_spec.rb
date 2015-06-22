require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authentication_token) }

  it { should_not be_valid }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  it { should validate_length_of(:name).is_at_least(4).is_at_most(30) }
  it { should validate_length_of(:email).is_at_least(8).is_at_most(30) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(30) }

  it { should allow_value('user@abc123.com').for(:email) }
  it { should_not allow_value('user@abc.', 'user@foo,com', 'user@foo+bar.com').for(:email) }

  it { should have_secure_password }

  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:authentication_token) }


  describe "#generate_authentication_token" do
    it "generate a unique token" do

    end

    it "generate another token when one already has been taken" do
      another_user = create(:user, name: 'anotheruser', email: 'another_user@abc.com', authentication_token: 'anothertoken123')
      user.generate_authentication_token
      expect(user.authentication_token).not_to eq another_user.authentication_token
    end
  end
end
