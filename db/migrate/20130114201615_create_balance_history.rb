class CreateBalanceHistory < ActiveRecord::Migration
  def change
    create_table :balance_histories do |t|
      t.string :action
      t.integer :amount
      t.references :user
      
      t.timestamps
    end
  end
end
