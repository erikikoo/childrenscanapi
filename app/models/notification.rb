class Notification < ApplicationRecord
  belongs_to :child

  enum visited: [:no, :yes]
  # enum periodo: [:manha, :matutino, :tarde, :vespertino]
  # enum acao: [:entrada, :saida]

  def self.countNotification(child)    
    Notification.where(created_at: Time.now, child_id: child, visited: :no).count    
  end

  
end
