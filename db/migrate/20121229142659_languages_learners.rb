class LanguagesLearners < ActiveRecord::Migration
  def change
    create_table :languages_learners do |t|
      t.integer :learner_id
      t.integer :language_id
    end
  end
end
