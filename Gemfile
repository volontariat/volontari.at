source "http://gems.github.com"
source 'http://rubygems.org'

gem 'bundler', '> 1.1.0'
ruby '1.9.3' if ENV['HEROKU']

gem 'voluntary', path: '../../voluntary/voluntary' #'0.1.0.rc2'
gem 'voluntary_text_creation', '0.0.3'
gem 'voluntary_core_module_emberjs', path: '../../voluntary/voluntary_core_module_emberjs' #'0.0.1'
gem 'voluntary_ranking', path: '../../voluntary/voluntary_ranking' #'0.0.1'

gem "rack-cors", "~> 0.2.4", :require => "rack/cors"
gem "thin", "~> 1.3.1", :require => false
gem "settingslogic", :git => "https://github.com/binarylogic/settingslogic.git"
gem "acts_as_markup", :git => "git://github.com/vigetlabs/acts_as_markup.git"
gem "auto_html", :git => "git://github.com/Applicat/auto_html"
gem "recaptcha", :require => "recaptcha/rails"
gem "sinatra", :require => false
gem "addressable", "~> 2.2", :require => "addressable/uri"
gem "jasmine", :git => "https://github.com/pivotal/jasmine-gem.git"

group :development do
  gem "linecache", "0.46", :platforms => :mri_18
  gem "capistrano", :require => false
  gem "capistrano_colors", :require => false
  gem "capistrano-ext", :require => false
  gem "yard", :require => false
end

group :test do
  gem "cucumber-rails", "1.3.0", :require => false
  gem "rspec-instafail", ">= 0.1.7", :require => false
  gem "webmock", "~> 1.7", :require => false
  gem "simplecov", :require => false
end

group :development, :test do
  gem "debugger", :platforms => :mri_19
  gem "ruby-debug", :platforms => :mri_18
end

group :assets do
  gem "therubyracer", :platforms => :ruby
  gem "asset_sync", :require => nil
end

group :production do
  gem "fastercsv", "1.5.5", :require => false
  gem "rack-ssl", :require => "rack/ssl"
  gem "rack-rewrite", "~> 1.2.1", :require => false
  gem "rack-google-analytics", :require => "rack/google-analytics"
  gem "rack-piwik", :require => false
  gem 'unicorn'
end
