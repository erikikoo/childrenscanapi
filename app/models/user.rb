class User < ApplicationRecord
    enum status: [:desativado, :ativo]


    has_many :monitor_users, dependent: :destroy
    has_many :sms_messages, through: :monitor_users
    
    has_many :children, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :prices
    
    #Validations
    validates_presence_of :name, :login, :password_digest
    validates :login, uniqueness: true, case_sensitive: false
 
    #encrypt password
    has_secure_password

    require 'ostruct'

   def self.allChild(user)
        if user.level === 3
            Child.all.order(:user_id)
        else
            Child.where(user_id: user.id).order("created_at DESC")
        end
   end

   def self.getAllSMSPerUser
        items = Hash.new        
        itens_array = Array.new

        i = 0
        User.all.each do |item|
            # items[item.name] = User.find(item.id).sms_messages.where(created_at: (Time.current.beginning_of_month..Time.current )).count
            itens_array.push({ :name => item.name, :quant => User.find(item.id).sms_messages.where(created_at: (Time.current.beginning_of_month..Time.current )).count})
            # i = i + 1
        end 
        
        return itens_array
    end
    
   
end
