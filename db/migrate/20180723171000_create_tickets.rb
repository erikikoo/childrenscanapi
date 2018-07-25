class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.references :user, foreign_key: true, default: 1
      t.integer :status, limit: 1, default: 1
      t.string :title
      t.text :notification

      t.timestamps
    end
  end
end
