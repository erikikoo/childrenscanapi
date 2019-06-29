class CreateMensalidades < ActiveRecord::Migration[5.2]
  def change
    create_table :mensalidades do |t|
      t.references :user, foreign_key: true
      t.user :child
      t.boolean :status

      t.timestamps
    end
  end
end
