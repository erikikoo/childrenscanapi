class Notification < ApplicationRecord
  belongs_to :child

  enum visited: [:no, :yes]
  

  def self.countNotification(child)    
    Notification.where(child_id: child, visited: :no).count
  end

  
end
