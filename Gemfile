source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'mysql2', '~> 0.5'

gem 'bootstrap', '~> 4.3.1'
gem 'sass-rails', '~> 5'
gem 'webpacker', '~> 4.0'
gem 'jbuilder'
gem 'multi_json', '~> 1.11', '>= 1.11.2'
gem 'active_model_serializers', '~> 0.10.0'
gem 'uglifier', '~> 4.1.20'
gem 'jquery-rails', '~> 4.3.5'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'will_paginate', '~> 3.3.0'
gem 'mini_magick', '~> 4.9.5'
# Redis
gem 'redis', '~> 4.1'
gem 'hiredis', '~> 0.6.3'
# Sitemap
gem 'sitemap_generator'
# Error reporting to Sentry
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'recaptcha'
# Sendgrid
gem 'sendgrid-ruby'
# Cors setup
gem 'rack-cors'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'solargraph'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'puma'
end

# API documentation and tests
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'rswag'
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'webdrivers', '~> 4.0', require: false
end
