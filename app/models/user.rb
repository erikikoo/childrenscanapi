class User < ApplicationRecord
   
    has_many :monitor_users, dependent: :destroy
    
   
    #Validations
   validates_presence_of :name, :login, :password_digest
   validates :login, uniqueness: true
 
   #encrypt password
   has_secure_password

   

   def self.allChild(user)
    if user.level === 3
        Child.all.order(:user_id)
    else
        Child.where(user_id: user.id).order("created_at DESC")
    end
end
end
