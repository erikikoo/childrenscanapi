class Child < ApplicationRecord
    has_many :sms_messages, dependent: :destroy
    
    belongs_to :user
    
    def self.allChild(user)
        if user.level === 3
            Child.all.order(:monitor_user_id)
        else
            Child.where(monitor_user_id: user.id).order("created_at DESC")
        end
    end
end
