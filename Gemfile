source 'http://rubygems.org'

gem 'bundler', '> 1.1.0'
ruby '1.9.3' if ENV['HEROKU']

gem 'rails', '3.2.8'

gem 'pg'

gem 'foreman', '0.46'

gem 'thin', '~> 1.3.1', require: false
gem 'rails_autolink'

# cross-origin resource sharing

gem 'rack-cors', '~> 0.2.4', require: 'rack/cors'

# authentication

gem 'devise'

# cannot load such file -- devise/schema (LoadError)
#gem 'devise_rpx_connectable'

# authorization
gem 'cancan'

gem 'remotipart', '~> 1.0'

gem 'omniauth', '1.0.3'
gem 'omniauth-facebook'
gem 'omniauth-tumblr'
gem 'omniauth-twitter'
gem 'twitter', '2.0.2'

# mail

# invalid byte sequence in US-ASCII on production
#gem 'markerb', git: 'https://github.com/plataformatec/markerb.git'
gem 'messagebus_ruby_api', '1.0.3'
gem 'airbrake'
gem 'newrelic_rpm'
gem 'rpm_contrib', '~> 2.1.7'

# model 
gem 'foreigner', '~> 1.1.0'
gem 'ancestry'
gem 'state_machine'
gem 'acts_as_list'
gem 'activerecord-import'
gem 'koala'
gem 'ransack' 
gem 'settingslogic', git: 'https://github.com/binarylogic/settingslogic.git'
gem 'faker' # needed not just for testing but for rake db:seed, too

# controller
gem 'has_scope'
gem 'friendly_id', '~> 4.0.0'

# view
gem 'simple-navigation'  
gem 'acts_as_markup', git: 'git://github.com/vigetlabs/acts_as_markup.git'
gem 'facebox-rails'
gem 'simple_form'
gem 'auto_html', git: 'git://github.com/Applicat/auto_html'

# Could not find a valid gem 'mobile_fu' (>= 0) in any repository
#gem 'mobile-fu'

gem 'will_paginate'
gem 'client_side_validations'
gem 'gon'

# file uploading

gem 'carrierwave', '0.6.2'
gem 'fog'
gem 'mini_magick', '3.4'

# JSON and API

gem 'json'
gem 'acts_as_api'

# localization

gem 'i18n-inflector-rails', '~> 1.0'
gem 'rails-i18n'

# queue

gem 'resque', '1.20.0'
gem 'resque-timeout', '1.0.0'

# ERROR:  Error installing SystemTimer:
# ERROR: Failed to build gem native extension.
# make: *** [system_timer_native.o] Error 1
#gem 'SystemTimer', '1.2.3', platforms: :ruby_18

# tags

gem 'acts-as-taggable-on', git: 'https://github.com/mbleigh/acts-as-taggable-on.git'

# URIs and HTTP

gem 'addressable', '~> 2.2', require: 'addressable/uri'
gem 'http_accept_language', '~> 1.0.2'
gem 'typhoeus'
gem 'capistrano'

# view
gem 'jquery-rails'
gem 'jquery-ui-rails'

# ffi dependency older than the one from selenium-webdriver
#gem 'pygments.rb'

gem 'twitter-bootstrap-rails'
gem 'simple-navigation-bootstrap'

# web

gem 'faraday'
gem 'faraday_middleware'

gem 'jasmine', git: 'https://github.com/pivotal/jasmine-gem.git'

group :development do
  #gem 'heroku'
  #gem 'heroku_san', '3.0.2', platforms: :mri_19
  gem 'capistrano', require: false
  gem 'capistrano_colors', require: false
  gem 'capistrano-ext', require: false
  gem 'linecache', '0.46', platforms: :mri_18
  gem 'yard', require: false

  # for tracing AR object instantiation and memory usage per request
  gem 'oink'
end

group :development, :test do
  gem 'awesome_print'
  gem 'debugger', platforms: :mri_19
  gem 'rspec-rails', '~> 2.10' 
  gem 'ruby-debug', platforms: :mri_18
end

group :test do
  gem 'capybara', '~> 1.1.2'
  gem 'capybara-webkit'
  gem 'cucumber-rails', '1.3.0', require: false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner', '0.7.1'

  gem 'timecop'
  gem 'factory_girl_rails', '1.7.0'
  gem 'fixture_builder', '0.3.3'
  gem 'fuubar', '>= 1.0'
  gem 'rspec-instafail', '>= 0.1.7', require: false
  gem 'selenium-webdriver', '~> 2.22.1'
  gem 'timecop'
  gem 'webmock', '~> 1.7', require: false

  gem 'spork', '~> 1.0rc2'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-cucumber'
  gem 'launchy'
end

group :production do # we don't install these on travis to speed up test runs
  # dependency nokogiri is incompatible with cucumber-rails
  #gem 'rails_admin', git: 'git://github.com/halida/rails_admin.git'
  gem 'fastercsv', '1.5.5', require: false
  gem 'rack-ssl', require: 'rack/ssl'
  gem 'rack-rewrite', '~> 1.2.1', require: false

  # analytics
  gem 'rack-google-analytics', require: 'rack/google-analytics'
  gem 'rack-piwik', require: 'rack/piwik', require: false
end

# configuration

group :heroku do
  gem 'pg'
  gem 'unicorn', '~> 4.3.0', require: false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'handlebars_assets'
  gem 'uglifier', '>= 1.0.3'

  # asset_sync is required as needed by application.rb
  gem 'asset_sync', require: nil
  
  gem 'coffee-script'
end

