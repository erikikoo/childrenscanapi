module Api::V1
    class EstatisticaController < ApplicationController
        require 'json'
        
        def index
            if @current_user.level === 3
                children = Child.where(status: 1).count
                users = User.where.not(level: 3).count
                notification_send_in_month = Notification.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current ).count
                notification_messages_sending = Notification.count
                last_child = Child.where("created_at >= ?", Time.now.to_date).limit(7)
                ticket = Ticket.where(status: 1).count
                
            else
                
                children = Child.where(status: 1, user_id: @current_user.id).count                 
                
                notification_send_in_month = Notification.where(user_id: @current_user.id).where(created_at: (Time.current.beginning_of_month..Time.current )).count
                
                notification_messages_sending = Notification.where(user_id: @current_user.id).count
                
            end    
            render json: {
                children: children,
                users: users,
                notification_send_in_month: notification_send_in_month,
                notification_messages_sending: notification_messages_sending,
                last_child: @current_user.level === 3 ? last_child.as_json(include:[:user => {only: [:name]}]) : nil ,
                ticket: ticket
                
            }
        end    


        def sms_all_per_user
            @teste = User.getAllSMSPerUser
            render json: @teste
        end
        # private 

        
    end
end
