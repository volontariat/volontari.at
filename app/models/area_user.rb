class AreaUser < ActiveRecord::Base
  self.table_name = 'areas_users'
  
  belongs_to :area
  belongs_to :user
  
  after_create :increment_area_users_count
  after_destroy :decrement_area_users_count
  
  private
  
  def increment_area_users_count
    area.users_count.increment!
  end
  
  def decrement_area_users_count
    area.users_count.decrement!
  end
end