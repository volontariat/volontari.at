module Applicat
  module Mvc
    module Model
      module Resource
        module Base
          def self.included(base)
            base.class_eval do
              #has_many :role_assignments, :class_name => 'Role', :as => :authorizable
              
              cattr_reader :per_page
              @@per_page = 20
  
              attr_accessor :current_user
              
              if self.table_exists?
                #reflections.values.select{|r| [:has_one, :has_many].include?(r.macro)}.map(&:name)
                
                columns.map(&:name).select{|c| c.match('_id')}.each do |column|
                  association = column.split('_id').first.classify
                  
                  define_method "#{association.underscore}_name" do
                    self.send("#{association.underscore}").try(:name)
                  end
                  
                  accessible_attributes << "#{association.underscore}_name"
                  
                  define_method "#{association.underscore}_name=" do |name|
                    return if name.blank?
                    
                    association_type = association
                    
                    if self.class.columns.map(&:name).include?("#{association.underscore}_type")
                      association_type = self.send("#{association.underscore}_type")
                    end
                    
                    self.send("#{association.underscore}=", association_type.constantize.find_or_initialize_by_name(name))
                  end
                end
              end
              
              #def role_for?(role_name, user)
              #  return true if new_record?
              # 
              #  role_assignments.joins(:users).where('roles.name = ? AND users.id = ?', role_name, user.id).any?
              #end
      
              def to_s
                self.name rescue self.class.name.humanize
              end
            end
          end
        end
      end
    end
  end
end