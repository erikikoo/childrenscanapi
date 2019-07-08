module Api::V1
  class NotificationsController < ApplicationController
    # before_action :set_notification, only: [:show, :update, :destroy]
    before_action :getLastNotifications, only: [:index]
    skip_before_action :authenticate_request
    # GET /notifications
    def index
      render json: @notifications, :include => {:child => {:only => :name}}
    end

    # GET /notifications/1
    def show
      @notifications = []
      
      child = Child.find(params[:id])
      notification_ids = child.notifications.where("created_at >= ?", Date.current).order(created_at: :DESC)
      
      child.notifications.update(visited: :yes)
      
      notification_ids.each do |n|
        @notifications  << {child_name: child.name, created_at: n.created_at, mensagem: PushNotification.getNotifications(n.notification_id)['contents']['en']}
      end
      render json: @notifications
    end

    # POST /notifications
    def create    
      notification = Notification.new(notification_params)
      
      user_id = params[:notification][:user_id]
      periodo = params[:setup][:periodo]
      acao = params[:setup][:acao]

      child = CheckChild.hasChild?(params[:setup][:child], user_id)
      
      if child
        devices_id = []  
        devices = child.devices
        
        devices.each do |d|
          devices_id << d.uid_onesignal         
        end
        
        customMessage = Message.find_by(periodo: periodo, acao: acao, user_id: user_id)
        
        if customMessage          
          message = GenerateMessage.replace_aluno(customMessage.message_text, child)
        else
          message = GenerateMessage.gerar(periodo, acao, child)
        end
        
        
        notification_response = PushNotification.send(devices_id, message)        
        
        if (notification_response)

          Notification.create(user_id: params[:notification][:user_id], child_id: child.id, notification_id: notification_response["id"])
          
          getLastNotifications()

          render json: {status: 201, message: "Mensagem enviada com sucesso!", location: @notifications.as_json(:include => {:child => {:only => :name}})}
        else
          render json: {error: notification_response, message: "Ops! ocorreu um erro ao enviar a mensagem"}          
        end
        
      else
        render json: {status: 404, message: "Criança não encontrada!"}
      end  
     
    end

    # PATCH/PUT /notifications/1
    def update
      if @notification.update(notification_params)
        render json: @notification
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    # DELETE /notifications/1
    def destroy
      @notification.destroy
    end

    def send_evento_for_all_devices
      evento_id = params['id']  
      $evento = Event.find(evento_id);

      if $evento && $evento.image.attached?         
        sending = PushNotification.sendNotificationForAllDevices($evento, $evento.id,url_for($evento.image))
      else 
        sending = PushNotification.sendNotificationForAllDevices($evento, $evento.id) if $evento
      end
     
      if sending        
        render json: {status: 200, message: "Notificação enviada para todos os celulares cadastrados!"}  
      else        
        render json: {status: 404, message: "Ops!!, não foi possível enviar a notificação"}
      end
    end



    private
      def getLastNotifications
        @notifications = Notification.select(:child_id, :created_at)
                                     .where("created_at >= ?", Date.current)
                                     .order(created_at: :DESC)
                                     .includes(:child)
      end      

      # Use callbacks to share common setup or constraints between actions.
      def set_notification
        @notification = Notification.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def notification_params
        params.require(:notification).permit(:user_id, :child, setup: [:periodo, :acao])
      end
  end
end