# This migration comes from voluntary_classified_advertisement_engine (originally 20130809134227)
class AddTaskIdToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :task_id, :string
  end
end