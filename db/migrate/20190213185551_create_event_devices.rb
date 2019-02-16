class CreateEventDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :event_devices do |t|
      t.references :event, foreign_key: true
      t.references :device, foreign_key: true
      
      t.timestamps
    end
  end
end
