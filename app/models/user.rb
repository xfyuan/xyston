class User < ActiveRecord::Base
  validates_presence_of :name, :email

  validates_length_of :name, in: 4..30
  validates_length_of :email, in: 8..30
  validates_length_of :password, in: 6..30

  validates_uniqueness_of :name
  validates_uniqueness_of :email

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password

  before_create :generate_authentication_token

  def generate_authentication_token
    return if authentication_token.present?
    self.authentication_token = SecureRandom.uuid.tr('-', '')
  end
end
