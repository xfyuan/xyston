ENV["RAILS_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)

require "rspec/rails"
require "shoulda/matchers"
require "email_spec"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

# module Features
#   # Extend this module in spec/support/features/*.rb
#   include Formulaic::Dsl
# end

RSpec.configure do |config|
  # config.include Features, type: :feature
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.include Request::JsonHelpers, :type => :controller
  config.include Request::HeadersHelpers, :type => :controller

  config.before(:each, type: :controller) do
    include_default_accept_headers
  end
end

ActiveRecord::Migration.maintain_test_schema!
# Capybara.javascript_driver = :webkit
