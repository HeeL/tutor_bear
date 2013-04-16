class CreateLanguageTranslations < ActiveRecord::Migration
  def up
    Language.create_translation_table!({
      name: :string
    }, {
      migrate_data: true
    })
  end

  def down
    Language.drop_translation_table!
  end
end
