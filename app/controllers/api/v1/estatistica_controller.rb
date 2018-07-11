module Api::V1
    class EstatisticaController < ApplicationController
        def index
            children = Child.where(status: 1).count
            if @current_user.level === 3
                users = User.count
                sms_send_in_month = SmsMessage.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current )
                sms_messages_sending = SmsMessage.count                
                sms = Sms.new
                sms_saldo = sms.getSaldo["cause"]
            else 
                #sms_messages = SmsMessage.where(user_id: @current_user.id).count
                sms_messages_sending = SmsMessage.getAllSms(@current_user.id)
            end    
            render json: {
                children: children,
                users: users,
                sms_send_in_month: sms_send_in_month,
                sms_messages_sending: sms_messages_sending,                
                sms_saldo: sms_saldo
            }
        end
    end
end
