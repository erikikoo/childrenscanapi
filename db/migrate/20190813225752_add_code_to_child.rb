class AddCodeToChild < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :code, :string, null: true
  end
end
