class RemoveLanguagesFromLearnersTeachers < ActiveRecord::Migration
  def up
    remove_column :learners, :languages
    remove_column :teachers, :languages
  end
end
