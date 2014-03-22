# This migration comes from voluntary_scholarship_engine (originally 20140314154216)
class CreateScholarshipIterationParticipations < ActiveRecord::Migration
  def change
    create_table :scholarship_iteration_participations do |t|
      t.integer :iteration_id
      t.integer :user_id
      t.integer :roles
      t.integer :team_id
      t.text :text
      t.string :state
      t.timestamps
    end 
    
    add_index :scholarship_iteration_participations, [:iteration_id, :user_id], unique: true, name: 'index_scholarship_iteration_participations_on_iteration_user'
  end
end
