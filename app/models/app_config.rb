# Copyright (c) 2010-2011, Diaspora Inc.  This file is
# licensed under the Affero General Public License version 3 or later.  See
# the COPYRIGHT file.

require 'uri'

class AppConfig < Settingslogic
  def self.source_file_name
    if ENV['application_yml'].present?
      puts "using remote application.yml"
      return ENV['application_yml']
    end
    config_file = Rails.root.join("config", "application.yml")
    if !File.exists?(config_file) && (Rails.env == 'test' || Rails.env.include?("integration") || EnvironmentConfiguration.heroku?)
      config_file = Rails.root.join("config", "application.yml.example")
    end
    config_file
  end
  
  def self.load!
  end
  
  def self.setup!
  end
  
  source source_file_name
  namespace Rails.env
  
  def self.new_relic_app_name
    self[:new_relic_app_name] || self[:pod_uri].host
  end
end
