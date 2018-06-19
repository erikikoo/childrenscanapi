class AddMonitorUserToChildren < ActiveRecord::Migration[5.2]
  def change
    add_reference :children, :monitor_user, foreign_key: true
  end
end
