source 'https://rubygems.org'

gem 'rails',           '4.0.1'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'angularjs-rails'

gem 'devise'
gem 'haml'

gem 'sass-rails'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails'

gem 'puma'
gem 'ng-rails-csrf'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :test do
  gem 'spring'
  gem 'minitest', '~> 4.7'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'minitest-rails-capybara'
  gem 'simplecov', require: false
end

group :test, :development do
  gem 'sqlite3'
  gem 'guard-minitest'
  gem 'jasmine-rails'
  gem 'guard-jasmine'
  gem 'database_cleaner'
  gem 'foreman'
  gem 'minitest-reporters'
end
