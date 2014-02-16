source 'https://rubygems.org'

ruby "2.1.0"

gem 'rails',           '4.1.0beta1'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'angularjs-rails'

gem 'execjs'

gem 'devise'
# gem 'pundit'
gem 'chronic_duration'
gem 'chronic'

gem 'haml'
gem 'sass-rails'
gem 'foundation-rails', '~> 5.0.0'
gem 'font-awesome-rails'
gem 'bourbon'

gem 'active_model_serializers'

gem 'puma'
gem 'ng-rails-csrf'

gem "bower-rails", "~> 0.6.0"

gem 'intercom-rails', '~> 0.2.24'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'simplecov', require: false
end

group :development do
  gem 'quiet_assets'
end

group :test, :development do
  gem 'sqlite3'
  # gem 'jasmine'
  gem 'guard-jasmine'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'foreman'
  # gem 'spring'
  # gem 'spring-commands-rspec'
end
