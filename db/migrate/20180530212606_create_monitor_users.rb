class CreateMonitorUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :monitor_users do |t|
      t.string :login
      t.string :name
      t.integer :level, default: 1
      t.references :user, foreign_key: true
      t.string :password_digest
      t.integer :access_count, default: 0

      t.timestamps
    end
  end
end
