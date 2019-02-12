source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Serializing API Output
gem 'active_model_serializers'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# enable Cross-Origin Resource Sharing (CORS)
gem 'rack-cors'

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.0'
  gem "factory_bot_rails"
  gem 'faker'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Unit test
  gem 'rspec-rails', '~> 3.8'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

