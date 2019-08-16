class AddCustomUidToChildren < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :custom_uid, :string, null: true
  end
end
