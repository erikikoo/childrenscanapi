class CreateDeviceChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :device_children do |t|
      t.references :child, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
