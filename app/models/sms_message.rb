class SmsMessage < ApplicationRecord
  belongs_to :monitor_user
  belongs_to :child
  
  enum periodo: [:manha, :matutino, :tarde, :vespertino]
  enum acao: [:entrada, :saida]


  
  def self.allChild(u)
    if u.level === 3
      SmsMessage.includes(:monitor_user, :child).all.order('created_at DESC')
    else           
      SmsMessage.includes(:monitor_user, :child).where(monitor_user_id: u.id).order('created_at DESC')
    end
    #, :include => child: {:only =>[:contato, :responsavel]},monitor_user: {:only =>[:name]} }
  end

  

end
