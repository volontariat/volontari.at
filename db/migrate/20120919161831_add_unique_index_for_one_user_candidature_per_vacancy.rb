class AddUniqueIndexForOneUserCandidaturePerVacancy < ActiveRecord::Migration
  def up
    add_index :candidatures, [:user_id, :vacancy_id], unique: true
  end

  def down
    remove_index :candidatures, [:user_id, :vacancy_id]
  end
end
