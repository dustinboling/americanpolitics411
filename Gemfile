source 'http://rubygems.org'

gem 'rails', '3.1.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# basic gems needed for infrastructure
gem 'pg'
gem 'json'
gem 'cancan'
gem 'sorcery'
gem 'nokogiri'
gem 'jquery-rails'
gem 'redis'
gem 'sunlight'
gem 'congress'
gem 'highline'
gem 'youtube_it'
gem 'twitter'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'feedzirra'
gem 'ruby-hmac', '~> 0.3'
# gem 'amazon-ecs', github: 'jugend/amazon-ecs'
# gem 'amazon-ecs', :path => 'vendor/plugins/amazon-ecs'
gem 'jquery-datatables-rails', :path => "vendor/gems/jquery-datatables-rails-1.10.0"
gem 'transparency_data', github: 'asebastian/transparency-data'

# helpful helper gems
# gem 'railroady'
# gem 'annotate', '~> 2.4.1.beta'

# Gems for development mode only.
gem 'rspec-rails', :group => [:test, :development]
group :test, :development do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'faker'
end

group :production do
  gem 'unicorn'
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.3', :require => 'sass'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
group :development do 
  gem 'unicorn'
end

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

