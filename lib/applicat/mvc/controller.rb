#module Applicat::Mvc::Controller
module Applicat
  module Mvc
    module Controller
      def self.included(base)
        base.class_eval do
          include RailsInfo::Controller::ExceptionDiagnostics
          
          include ErrorHandling
          include TransitionActions
          
          protect_from_forgery
             
          layout proc { |controller| controller.request.xhr? || !controller.params[:is_ajax_request].nil? ? false : 'application' }
           
          helper :all
          helper_method :controller_action?, :resource_exists?, :layout_presenter 

          def controller_action?(input_controller, input_action)
            if "#{input_controller}/#{input_action}" == "#{controller_name}/#{action_name}"
              return true
            else
              return false
            end
          end

          def resource_exists?(name)
            if eval("@#{name}.nil?") || (eval("@#{name}.class.name") != name.classify && eval("@#{name}.class.superclass.name") != name.classify) || eval("@#{name}.id.nil?")
              return false
            else
              return true
            end
          end
                    
          def help
            helper = Helper.instance
            helper.controller = self 
            return helper
          end
          
          def layout_presenter
            @layout_presenter ||= "Layout::#{_layout.classify}Presenter".constantize.new(
              self.view_context, resource: self.respond_to?(:resource) ? resource : nil
            )
          end
          
          protected         
          
          def eager_load_polymorphs(list, includes)
            polymorphs = {}
            
            logger.debug "eager_load_polymorphs for list length: #{list.length}"
            
            list.each do |record|
              includes.each do |include|
                include = include.first if include.is_a?(Array)
                
                polymorphs[eval("record.#{include}_type")] ||= [] 
                polymorphs[eval("record.#{include}_type")] << eval("record.#{include}_id")
              end
            end
            
            logger.debug "Load polymorphs: #{polymorphs.keys.join(', ')}"
            
            polymorphs.each do |type,ids|
              polymorphs[type] = type.constantize.find(ids)
            end
            
            list_index = 0
            
            list.each do |record|
              includes.each do |include|
                polymorphs[eval("record.#{include}_type")].each do |polymorph|
                  next unless polymorph.id == eval("record.#{include}_id")
                  
                  eval("list[list_index].#{include} = polymorph")
                  
                  break
                end
              end
              
              list_index += 1
            end
            
            # free memory
            polymorphs.each do |type,ids|
              polymorphs.delete(type)
            end
            
            return list
          end         
          
          def model_name
            self.class.name.gsub('Controller', '').classify
          end
          
          def set_i18n_locale_from_params
            if params[:locale]
              if I18n.available_locales.include?(params[:locale].to_sym)
                I18n.locale = params[:locale]
              else
                flash.now[:notice] = "#{params[:locale]} translation not available"
                logger.error flash.now[:notice]
              end
            end
          end
         
          def js_help
            js_helper = JavaScriptHelper.instance
            js_helper.controller = self
            return js_helper
          end
          
          def store_location
            session[:"user.return_to"] = request.fullpath
          end
          
          private
          
          def exception_action(exception)
            @exception_catched = true
            
            if Rails.env == 'production'
              notify_airbrake(exception)
              logger.error "INTERNAL SERVER ERROR FOR REQUEST: " + exception.message
              logger.error exception.backtrace.join("\n")
            else
              raise exception
            end
            
            if !request.env['REQUEST_URI'].match(/\/assets\//).nil?
              render :text => '', :layout => false
            elsif exception.is_a?(ActiveRecord::RecordNotFound)
              render 'pages/exception_404', :layout => 'application'
            else
              render 'pages/exception_500', :layout => 'application'
            end
          end
        end
      end
      
      class Helper
        include Singleton
        #include ActionView::Helpers::TextHelper
        include ActionView::Helpers
        include ActionView::Helpers::CaptureHelper
        include ActionView::Helpers::UrlHelper
        
        attr_accessor :controller
        
        # Proxy Pattern use here cause of  NoMethodError at help.link_to('destroy', send("#{@resource_class.name.downcase}_path", @resource_instance), :confirm => 'Are you sure?', :method => :delete) in presenters
        # undefined method `protect_against_forgery?' for #<ApplicationController::Helper:0x804da10>
        def method_missing(name, *args)
          @controller.send(name, *args) unless @controller.nil?
        end
      end
      
      class JavaScriptHelper
        include Singleton
        include ActionView::Helpers::JavaScriptHelper
      end 
    end
  end
end