class MonitorUser < ApplicationRecord
  belongs_to :user
  has_many :sms_messages, dependent: :destroy
  
   #Validations
   validates_presence_of :login, :password_digest
   validates :login, uniqueness: true
  
  #encrypt password
  has_secure_password

  def self.allMonitor(user)
    if user.level === 3
        MonitorUser.all.order(:user_id)
    else
        MonitorUser.includes(:user).where(user_id: user.id).order('id DESC')
    end
end
  
end
