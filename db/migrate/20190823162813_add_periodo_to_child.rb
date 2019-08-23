class AddPeriodoToChild < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :periodo, :integer
  end
end
