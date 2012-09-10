class UserRole < ActiveRecord::Base
  self.table_name = 'users_roles'
  
  belongs_to :user
  belongs_to :role
end