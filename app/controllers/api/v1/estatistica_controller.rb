module Api::V1
    class EstatisticaController < ApplicationController
        def index
            children = Child.where(status: 1).count
            if @current_user.level === 3
                users = User.count
                sms_messages = SmsMessage.count
                sms_messages_sending = SmsMessage.where(status: true).count
                sms_messages_no_sending = SmsMessage.where(status: false).count
                sms = Sms.new
                sms_saldo = sms.getSaldo
            else 
                sms_messages = SmsMessage.where(user_id: @current_user.id).count
                sms_messages_sending = SmsMessage.where(user_id: @current_user.id, status: true).count
                sms_messages_no_sending = SmsMessage.where(user_id: @current_user.id, status: false).count
            end    
            render json: {
                children: children,
                users: users,
                sms_messages: sms_messages,
                sms_messages_sending: sms_messages_sending,
                sms_messages_no_sending: sms_messages_no_sending,
                sms_saldo: sms_saldo
            }
        end
    end
end
