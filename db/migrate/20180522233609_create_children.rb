class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.string :nome
      t.string :contato
      t.date :nascimento
      t.string :responsavel
      t.string :parentesco
      t.string :sexo
      
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
