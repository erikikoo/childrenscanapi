class AddUserToChildren < ActiveRecord::Migration[5.2]
  def change
    add_reference :children, :user, foreign_key: true
  end
end
