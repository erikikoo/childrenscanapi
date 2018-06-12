class SmsMessage < ApplicationRecord
  belongs_to :monitor_user
  belongs_to :child
  
  def self.allChild(u)
    if u.level === 3
      SmsMessage.includes(:monitor_user, :child).all.order('created_at DESC')
    else     
      SmsMessage.includes(:monitor_user, :child).where(user_id: u.id).order('created_at DESC')
    end
    #, :include => child: {:only =>[:contato, :responsavel]},monitor_user: {:only =>[:name]} }
  end

end
