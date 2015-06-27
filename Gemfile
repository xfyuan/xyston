source "https://rubygems.org"

ruby "2.2.2"

gem "active_model_serializers", '~> 0.8.3'
gem 'bcrypt', '~> 3.1.7'
gem "kaminari"
gem "pg"
gem "rails", "4.2.2"
# gem "delayed_job_active_record"
# gem "email_validator"
# gem "i18n-tasks"
# gem "rack-canonical-host"
# gem "recipient_interceptor"

# Simple gem that allows you to run multiple ActiveRecord::Relation using hash. Perfect for APIs.
# https://github.com/kollegorna/active_hash_relation
gem 'active_hash_relation'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'

gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'puma'
  gem 'annotate', '~> 2.6.6'
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails", ">= 3.2"
end

group :test do
  gem "database_cleaner"
  gem "shoulda-matchers", require: false
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  # gem "capybara-webkit", ">= 1.2.0"
  # gem "formulaic"
  # gem "launchy"
end

group :staging, :production do
  gem "unicorn"
  gem "rack-timeout"
end
