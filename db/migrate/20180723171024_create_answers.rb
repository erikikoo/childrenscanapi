class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :ticket, foreign_key: true
      t.text :answer
      t.integer :status, limit: 1, default: 0

      t.timestamps
    end
  end
end
