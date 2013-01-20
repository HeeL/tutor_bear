class LanguagesTeachers < ActiveRecord::Migration
  def change
    create_table :languages_teachers do |t|
      t.integer :teacher_id
      t.integer :language_id
    end
  end
end
