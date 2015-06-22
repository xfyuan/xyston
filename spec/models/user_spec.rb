require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it { should be_valid }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  it { should validate_length_of(:name).is_at_least(4).is_at_most(30) }
  it { should validate_length_of(:email).is_at_least(8).is_at_most(30) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(30) }

  it { should allow_value('user@abc123.com').for(:email) }
  it { should_not allow_value('user@abc.', 'user@foo,com', 'user@foo+bar.com').for(:email) }
end
