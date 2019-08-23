class AddTipoViagemToChild < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :tipo_viagem, :integer, limit: 1, null: true
  end
end
