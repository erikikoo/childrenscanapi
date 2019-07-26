class CreateEscolaAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :escola_alerts do |t|
      t.references :escola, foreign_key: true, null: true 
      t.references :alert, foreign_key: true

      t.timestamps
    end
  end
end
