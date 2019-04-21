class CreateEventChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :event_children do |t|
      t.references :child, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
