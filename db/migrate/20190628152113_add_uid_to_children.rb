class AddUidToChildren < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :uid, :string
  end
end
