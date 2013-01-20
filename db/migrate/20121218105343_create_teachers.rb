class CreateTeachers < ActiveRecord::Migration

  def change
    create_table :teachers do |t|
      t.integer :min_price, default: 0
      t.integer :max_price, default: 0
      t.string :languages, default: ''
      t.references :user
      
      t.timestamps  
    end
  end

end
