class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :uid_onesignal
      t.string :uid_device
      t.timestamps
    end
  end
end
