# This migration comes from voluntary_scholarship_engine (originally 20140311173818)
class CreateScholarshipTeams < ActiveRecord::Migration
  def change
    create_table :scholarship_teams do |t|
      t.string :name
      t.string :slug
      t.text :text
      t.string :kind
      t.string :github_handle
      t.string :twitter_handle
      t.string :state
      t.timestamps
    end 
    
    add_index :scholarship_teams, :name, unique: true
    add_index :scholarship_teams, :slug, unique: true
    
    create_table :scholarship_team_memberships do |t|
      t.integer :team_id
      t.integer :user_id
      t.integer :roles
      t.text :text
      t.string :state
      t.timestamps
    end 
    
    add_index :scholarship_team_memberships, [:team_id, :user_id], unique: true
  end
end
