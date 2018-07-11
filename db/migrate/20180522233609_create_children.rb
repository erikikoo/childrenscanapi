class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.string :name
      t.string :contato
      t.date :nascimento
      t.string :responsavel
      t.integer :parentesco, limit: 1
      t.integer :sexo, limit: 1      
      t.integer :status, limit: 1, default: 1

      t.timestamps
    end
  end
end
