source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'responders'
gem 'haml-rails'
gem 'twitter-bootstrap-rails', :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'devise'
gem 'omniauth-github', :git => 'git@github.com:intridea/omniauth-github.git'
gem 'thin'
gem 'httpclient'
gem 'grit'
gem 'kaminari'
gem 'simple_form'
gem 'systemu'

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  gem 'launchy'
  gem 'database_cleaner'
  group :darwin do
    gem 'rb-fsevent', :require => false #if RUBY_PLATFORM =~ /darwin/i
  end
  gem 'guard-rspec'
  gem 'guard-rails-assets'
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano_colors'
end