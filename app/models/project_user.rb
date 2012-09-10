class ProjectUser < ActiveRecord::Base#
  self.table_name = 'projects_users'
  
  belongs_to :project
  belongs_to :vacancy
  belongs_to :user
  belongs_to :role
  
  validates :project_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: [:project_id, :vacancy_id] }
  
  attr_accessible :project_id, :vacancy_id, :user_id, :role_id
end