source 'http://rubygems.org'

gem 'bundler', '> 1.1.0'

gem 'voluntary', github: 'volontariat/voluntary' # path: '../voluntary'
gem 'voluntary_recruiting', github: 'volontariat/voluntary_recruiting' #path: '../voluntary_recruiting'#'~> 0.0.1'
gem 'voluntary_classified_advertisement', github: 'volontariat/voluntary_classified_advertisement' #'~> 0.2.0' #, path: '../voluntary_classified_advertisement'
gem 'voluntary_text_creation', github: 'volontariat/voluntary_text_creation' # '~> 0.2.0'#, path: '../voluntary_text_creation'
gem 'voluntary_translation', github: 'volontariat/voluntary_translation' # '~> 0.2.0'
gem 'voluntary_scholarship', github: 'volontariat/voluntary_scholarship' #'~> 0.1.0'
gem 'voluntary_music_metadata_enrichment', github: 'volontariat/voluntary_music_metadata_enrichment' # '~> 0.2.0'
gem 'voluntary-ember_js', github: 'volontariat/voluntary-ember_js'
gem 'voluntary_ranking', github: 'volontariat/voluntary_ranking'#'~> 0.0.2'#github: 'volontariat/voluntary_ranking' 
gem 'voluntary_brainstorming', '~> 0.0.2'

# voluntary_music_metadata_enrichment requirements
gem 'musicbrainz', github: 'localhots/musicbrainz', branch: '0.8.0.rc1'
gem 'lastfm', github: 'volontarian/ruby-lastfm', branch: 'handle_nil_releasedates'

# core
gem 'rack-cors', '~> 0.2.4', require: 'rack/cors'
gem 'thin', '~> 1.3.1', require: false
#gem 'sprockets', '~> 2.12.3' # 3.0 renames manifest-x.json to .sprockets-manifest-x.json which cannot be handled by old capistrano version yet

# model 
gem 'settingslogic', git: 'https://github.com/binarylogic/settingslogic.git'

# view 
gem 'acts_as_markup', git: 'git://github.com/vigetlabs/acts_as_markup.git'
gem 'recaptcha', require: 'recaptcha/rails'

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
  #gem 'capistrano', '~> 3.4.0', require: false
  gem 'capistrano_colors', '~> 0.5.5', require: false
  #gem 'capistrano-ext', '~> 1.2.1', require: false
  gem 'capistrano-rails', '~> 1.1.2', require: false
  gem 'capistrano-bundler', '~> 1.1.4', require: false
  gem 'capistrano-rbenv', '~> 2.0.3', require: false
  gem 'capistrano-cookbook', '~> 0.2.1', require: false
  gem 'net-ssh', '2.7.0'
  gem 'yard', '~> 0.7', require: false
  gem 'spring',                   '~> 1.3.4'
  gem 'spring-commands-rspec',    '~> 1.0.4'
  gem 'spring-commands-cucumber', '~> 1.0.1'
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
  gem 'unicorn'
  gem 'airbrake',                '~> 4.1.0'
end
        