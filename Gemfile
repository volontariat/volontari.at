source "http://gems.github.com"
source 'http://rubygems.org'

gem 'bundler', '> 1.1.0'
ruby '1.9.3' if ENV['HEROKU']

gem 'voluntary', git: 'git://github.com/volontariat/voluntary.git'
gem 'voluntary_text_creation', git: 'git://github.com/volontariat/voluntary_text_creation.git'
gem 'voluntary_translation', git: 'git://github.com/volontariat/voluntary_translation.git'
gem 'voluntary_classified_advertisement', git: 'git://github.com/volontariat/voluntary_classified_advertisement.git'
gem 'voluntary_scholarship', git: 'git://github.com/volontariat/voluntary_scholarship.git'

# core
gem 'rack-cors', '~> 0.2.4', require: 'rack/cors'
gem 'thin', '~> 1.3.1', require: false

# model 
gem 'settingslogic', git: 'https://github.com/binarylogic/settingslogic.git'

# view 
gem 'acts_as_markup', git: 'git://github.com/vigetlabs/acts_as_markup.git'
gem 'auto_html', git: 'git://github.com/Applicat/auto_html'
gem 'recaptcha', require: 'recaptcha/rails'
gem "will_paginate", github: "mislav/will_paginate"

# queue

gem 'sinatra', require: false

# URIs and HTTP

gem 'addressable', '~> 2.2', require: 'addressable/uri'

# test

gem 'jasmine', git: 'https://github.com/pivotal/jasmine-gem.git'

# misc

# invalid byte sequence in US-ASCII on production
#  gem 'markerb', git: 'https://github.com/plataformatec/markerb.git'

group :development do
  gem 'mysql2', '~> 0.3.13'
  gem 'linecache', '0.46', platforms: :mri_18
  gem 'capistrano', '~> 2.15.5', require: false
  gem 'capistrano_colors', '~> 0.5.5', require: false
  gem 'capistrano-ext', '~> 1.2.1', require: false
  gem 'yard', '~> 0.7', require: false
end

group :test do
  gem 'cucumber-rails', '~> 1.3.0', require: false
  gem 'rspec-instafail', '~> 0.2.4', require: false
  gem 'webmock', '~> 1.8.11', require: false
  gem 'simplecov', '~> 0.7.1', require: false
end

group :development, :test do
  gem 'debugger', platforms: :mri_19
  gem 'ruby-debug', '~> 0.10.4', platforms: :mri_18
end

gem 'therubyracer', '~> 0.12.0', platforms: :ruby
  
# asset_sync is required as needed by application.rb
gem 'asset_sync', '~> 0.5.0', require: nil
 
group :production do
  # dependency nokogiri is incompatible with cucumber-rails
  #  gem 'rails_admin', git: 'git://github.com/halida/rails_admin.git'
  gem 'fastercsv', '~> 1.5.5', require: false
  gem 'rack-ssl', '~> 1.3.3', require: 'rack/ssl'
  gem 'rack-rewrite', '~> 1.2.1', require: false
  
  # analytics
  gem 'rack-google-analytics', '~> 0.11.0', require: 'rack/google-analytics'
  gem 'rack-piwik', '~> 0.1.3', require: 'rack/piwik', require: false
  gem 'unicorn'
end
        