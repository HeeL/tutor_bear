class CreateContactLogs < ActiveRecord::Migration
  def change
    create_table :contact_logs do |t|
      t.integer :user_sent
      t.integer :user_received
      t.string  :received_as
      t.timestamps
    end
  end
end
