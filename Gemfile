source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby File.read(File.join(__dir__, '.ruby-version'))

gem 'bootstrap-sass'
gem 'chartkick'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-bootstrap-views'
gem 'figaro'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'lean-elevators', github: 'renuo/lean-elevators'
gem 'lograge'
gem 'pg'
gem 'platform-api'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rails-ujs'
gem 'redis', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'slim-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'sidekiq'

group :production do
  gem 'sentry-raven'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bootstrap-generators', '~> 3.3.4'
  gem 'brakeman', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
  gem 'slim_lint', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov', require: false
end
