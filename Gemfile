source 'http://rubygems.org'

gem 'rails', '3.1.6'

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
gem 'transparency_data', github: 'asebastian/transparency-data'
gem 'highline'
gem 'youtube_it'
gem 'twitter'
gem 'jquery-ui-rails'

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
  gem 'thin'
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.3', :require => 'sass'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
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

