class User < ApplicationRecord
   enum status: [:desativado, :ativo]


    has_many :monitor_users, dependent: :destroy
    has_many :children, dependent: :destroy
    has_many :sms_messages, through: :monitor_users
    #Validations
   validates_presence_of :name, :login, :password_digest
   validates :login, uniqueness: true, case_sensitive: false
 
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
