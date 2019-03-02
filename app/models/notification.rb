class Notification < ApplicationRecord
  belongs_to :child

  enum visited: [:no, :yes]
  # enum periodo: [:manha, :matutino, :tarde, :vespertino]
  # enum acao: [:entrada, :saida]

  def self.countNotification(child)    
    Notification.where("created_at >= ? AND child_id = ? AND visited = ?", Date.current , child, 0).count    
    # Notification.where(created_at: Date.current).count    
  end

  
end
