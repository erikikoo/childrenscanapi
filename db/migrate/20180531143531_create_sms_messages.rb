class CreateSmsMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :sms_messages do |t|
      t.references :monitor_user, foreign_key: true
      t.references :child, foreign_key: true    
      t.integer :periodo, limit: 1
      t.integer :acao, limit: 1
      t.timestamps
    end
  end
end
