module Api::V1
  class AlertsController < ApplicationController
    before_action :set_alert, only: [:update, :destroy]
    before_action :getAllAlerts, only: [:index, :destroy, :update]
    skip_before_action :authenticate_request, only: [:app_get_alerts, :send_alert, :show, :app_get_alerts_sending]
    # GET /alerts
    def index
      render json: @alerts
    end

    def app_get_alerts
      getAllAlerts(params[:user_id])
      render json: @alerts
    end

    def app_get_alerts_sending
      device = Device.find_by(uid_device: params[:uid_device])
      # @alerts = device.children if device
      device = Device.find_by(uid_device: 'af144286de0ab9e2')
      @alerts = []

      if device
        $_alerts = []
      
        device.children.each do |child|        
           if child.escola 
                      
              alerts << child.escola.alerts.last
            
           end
        end      
        @alerts = $_alerts
      end
      puts "===================================="
      @alerts.each do |alert|
        puts alert.description
      end
      puts "===================================="
      
      # af144286de0ab9e2
      render json: @alerts
    end

    # GET /alerts/1
    def show      
      @alert = Alert.where(id: params[:id])
      render json: @alert
    end

    # POST /alerts
    def create
      @alert = Alert.new(alert_params)

      if @alert.save
        getAllAlerts()
        render json: @alerts, status: :created
      else
        render json: @alert.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /alerts/1
    def update
      if @alert.update(alert_params)
        render json: @alert
      else
        render json: @alert.errors, status: :unprocessable_entity
      end
    end

    # DELETE /alerts/1
    def destroy
      @alert.destroy
    end

    def send_alert
      $_escola_id = params[:escola_id].to_i
      $_alert_id = params[:alert_id]
      $_alert = Alert.find($_alert_id)
      
      if $_escola_id == 0
        $_children = Child.all        
      else
        $_escola = Escola.find($_escola_id)
        $_children = $_escola.children
      end

      $_devices_id = CheckDevice.getAllDevices $_children if $_children
      
      $_sender = PushNotification.sendNotificationForAllDevices($_alert, $_devices_id ) if $_alert && $_devices_id

      if $_sender
        if $_escola_id != 0
          EscolaAlert.create!(escola_id: $_escola_id, alert_id: $_alert_id)
        else
          EscolaAlert.create!(escola_id: :null, alert_id: $_alert_id)          
        end
        render json: {status: 200, message: "Alerta enviado para todos os celulares cadastrados!"}  
      else        
        render json: {status: 404, message: "Ops!!, não foi possível enviar o alerta, tente novamente"}
      end

    end
    def app_get_alert
      @alert = PushNotification.getNotifications params[:alert_id]
      render json: @alert
    end

    private

    def getAllAlerts user_id = nil
      $_admin_master = 1 #Usuario master ou alerta criado pelo adminMax
      if user_id
        $_user_id = user_id 
      else
        $_user_id = @current_user.id
      end

      @alerts = Alert.select(:id, :title, :description).where(user_id: [$_user_id, $_admin_master])
      # Alert.select(:id, :title, :description).where(user_id: [2, 1])
    end
    

      # Use callbacks to share common setup or constraints between actions.
      def set_alert
        @alert = Alert.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def alert_params
        params.require(:alert).permit(:title, :description, :user_id)
      end
  end
end
