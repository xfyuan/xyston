require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validation" do
    let(:user) { build :user }
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

    it { should have_many :products }
    it { should have_many :orders }
  end

  describe "#generate_authentication_token" do
    let(:user) { build :user }

    it "generate a unique token" do

    end

    it "generate another token when one already has been taken" do
      another_user = create(:user, name: 'anotheruser', email: 'another_user@abc.com', authentication_token: 'anothertoken123')
      user.generate_authentication_token
      expect(user.authentication_token).not_to eq another_user.authentication_token
    end
  end

  describe "#products association" do
    let(:user) { create :user }
    before do
      create_list :product, 3, user: user
    end

    it "destroys associated products" do
      products = user.products
      user.destroy
      products.each do |product|
        expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
        expect(Product.find(product)).not_to exist
      end
    end

    it "destroys associated products" do
      expect {
        user.destroy
      }.to change(User, :count).by(-1).and change(Product, :count).by(-3)
    end
  end
end
