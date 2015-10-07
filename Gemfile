source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# downgrade ruby because of furatto dependency issue
ruby '2.0.0'

gem 'rails', '4.1.8'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'

#Api gems
gem 'active_model_serializers'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails', '~> 3.3.0'
  gem "factory_girl_rails"
  gem 'ffaker'
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
end

gem "devise"
# instead of postman
gem 'sabisu_rails', github: "IcaliaLabs/sabisu-rails"
gem 'furatto', github: "IcaliaLabs/furatto-rails"
gem 'compass-rails', github: "Compass/compass-rails", branch: "master"
gem 'font-awesome-rails'
gem 'simple_form'