module Api::V1
    class EstatisticaController < ApplicationController
        def index
            if @current_user.level === 3
                children = Child.where(status: 1).count
                users = User.count
                sms_send_in_month = SmsMessage.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current ).count
                sms_messages_sending = SmsMessage.count                
                sms = Sms.new
                last_child = Child.where("created_at >= ?", Time.now.to_date).limit(7)
                ticket = Ticket.where(status: 1).count
                #sms_saldo = sms.getSaldoKingsms["body"] #to kingsms
                #sms_saldo = sms.getSaldoTelleGroup
                sms_saldo = sms.getSaldoOSMS
            else
                sms_send_in_month = SmsMessage.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current ).count
                children = Child.where(status: 1, user_id: @current_user.id).count                 
                # ticket = Ticket.joins("INNER JOIN answers ON answers.ticket_id = tickets.id AND answers.status = '0'").count
                # User.joins("INNER Join monitor_users ON monitor_users.user_id = users.id INNER Join  ")
                
                #sms_messages = SmsMessage.where(user_id: @current_user.id).count
                sms_messages_sending = SmsMessage.getAllSms(@current_user.id)
                
            end    
            render json: {
                children: children,
                users: users,
                sms_send_in_month: sms_send_in_month,
                sms_messages_sending: sms_messages_sending,                
                sms_saldo: sms_saldo,
                last_child: @current_user.level == 3 ? last_child.as_json(include:[:user => {only: [:name]}]) : nil ,
                ticket: ticket,
                empresa_de_sms: 'OSMS'
                #empresa_de_sms: 'Kingsms'
            }
        end
    end
end
