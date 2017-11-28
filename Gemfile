source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.2'

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'bootstrap-sass'
gem 'figaro'
gem 'devise'
gem 'lean-elevators', github: 'renuo/lean-elevators'
gem 'platform-api'
gem 'simple_form'
gem 'rails-ujs'
gem 'slim-rails'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'redis', '~> 3.0'
gem 'coffee-rails', '~> 4.2'
gem 'devise-bootstrap-views'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'font-awesome-rails'
gem 'chartkick'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'bootstrap-generators', '~> 3.3.4'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end

group :lint do
  gem 'brakeman', require: false
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
  gem 'slim_lint', require: false
end
