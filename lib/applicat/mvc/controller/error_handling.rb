module Applicat
  module Mvc
    module Controller
      module ErrorHandling
        #include Applicat::Errors
        
        def self.included(base)
          if Rails.env != 'development'
            base.class_eval do          
              rescue_from Applicat::Mvc::Controller::ErrorHandling::NoPermissionError do |e|
                response_for_error 403
              end
                 
              rescue_from ActiveRecord::RecordNotFound do |e|
                response_for_error 404
              end
              
              private
              
              def response_for_error(status)
                respond_to do |f|
                  # Show a neat html page inside the app's layout for web users
                  f.html { render :template => "errors/#{status}", :status => status }
            
                  # Everything else (JSON, XML, YAML, Whatnot) gets a blank page with status
                  # which can then be understood and processed by the API client, 
                  # JavaScript library (on Ajax) etc.
                  f.all { render :nothing => true, :status => status }
                end
              end
            end
          end
        end
        
        class NoPermissionError < StandardError
        end
      end
    end
  end
end