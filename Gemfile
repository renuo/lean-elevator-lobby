source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby File.read('.ruby-version').strip

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'bootstrap-sass'
gem 'figaro'
gem 'devise'
gem 'simple_form'
gem 'slim-rails'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'better_errors'
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

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
