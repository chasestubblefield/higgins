source 'https://rubygems.org'

gem 'rails', '~> 4.0.0.beta1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 4.0.0.beta1'
end

gem 'haml-rails'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'

gem 'puma'

gem 'resque', '~> 1.23'
gem 'faraday', require: false
# gem 'aws-sdk', require: false

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'debugger'
end

group :test do
  gem 'coveralls', require: false
end

group :production do
  gem 'mysql2'
end
