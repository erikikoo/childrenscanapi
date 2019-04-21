class CreateContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :contatos do |t|
      t.string :telefone
      t.string :celular
      t.string :url

      t.timestamps
    end
  end
end
