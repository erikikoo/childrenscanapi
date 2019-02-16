class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.float :value
      t.references :user, foreign_key: true
      t.date :date_current

      t.timestamps
    end
  end
end
