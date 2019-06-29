class AddVencMensalidadeToChildren < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :venc, :string
  end
end
