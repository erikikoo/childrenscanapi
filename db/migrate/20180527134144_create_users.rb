class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :contato
      t.integer :level, default: 2
      t.integer :access_count, default: 0
      t.integer :status, limit: 1, default: 1
      t.string :password_digest

      t.timestamps
    end
  end
end
