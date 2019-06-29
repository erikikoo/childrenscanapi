class AddEscolaIdToChildren < ActiveRecord::Migration[5.2]
  def change
    add_reference :children, :escola, foreign_key: true
  end
end
