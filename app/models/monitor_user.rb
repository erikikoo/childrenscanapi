class MonitorUser < ApplicationRecord
  belongs_to :user 
  
   #Validations
   validates_presence_of :login, :password_digest
   validates :login, uniqueness: {case_sensitive: false}
  
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
