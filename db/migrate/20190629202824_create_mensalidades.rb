class CreateMensalidades < ActiveRecord::Migration[5.2]
  def change
    create_table :mensalidades do |t|
      t.references :user, foreign_key: true
      t.references :child, foreign_key: true
      t.integer :mes, limit: 2
      # t.boolean :status, default: true

      t.timestamps
    end
  end
end
