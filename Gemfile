source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'slim-rails'
gem 'twitter-bootstrap-rails'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'bcrypt'
gem 'money-rails'
gem 'dry-validation'
gem 'i18n_generators'
gem 'interactor'
gem 'draper'
gem 'wisper'
gem 'httparty'
gem 'chartkick'
gem 'geocoder'

group :development, :test do
  gem 'pry-byebug'
  gem 'factory_girl_rails'
  gem 'factory_girl_sequences'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
