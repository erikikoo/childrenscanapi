class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      
      t.string :notification_id
      t.references :user, foreign_key: true
      t.references :child, foreign_key: true
      t.integer :visited, limit: 1, default: 0

      t.timestamps
    end
  end
end
