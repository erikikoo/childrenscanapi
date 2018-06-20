module Api::V1
  class SmsMessagesController < ApplicationController
    #before_action :getAllSms, only: [:index, :create]
    before_action :set_sms_message, only: [:show, :update, :destroy]
    #skip_before_action :authenticate_request
    
    # GET /sms_messages
    def index
      #@sms_messages = SmsMessage.includes(:monitor_user, :child).order('created_at DESC')            
      render json: @sms_messages, :include => {child: {:only =>[:contato, :responsavel]},monitor_user: {:only =>[:name]}}
    end

    def app_historico
      #@sms_messages = SmsMessage.where(user_id: @current_user.id).order(id: :desc).limit(5)
      #@sms_messages = SmsMessage.limit(5)
      if (@current_user.level <= 2) 
        @sms_messages = SmsMessage.where(monitor_user_id: @current_user.id).includes(:monitor_user, :child).order(id: :desc).limit(5)
      else
        @sms_messages = SmsMessage.where(user_id: @current_user.id).includes(:monitor_user, :child).order(id: :desc).limit(5)
      end  
      render json: @sms_messages, :include => {child: {:only =>[:nome, :contato]},monitor_user: {:only =>[:name]}}
    end

    # GET /sms_messages/1
    def show
      render json: @sms_message
    end

    # POST /sms_messages
    def create
      @sms_message = SmsMessage.new(sms_message_params)
      
      user = MonitorUser.find(@sms_message.monitor_user_id)      
      @sms_message.user_id = user.user_id
      
      user = Child.find_by(nome: params[:child], monitor_user_id: @sms_message.monitor_user_id)
      @sms_message.child_id = user.id if user
      
      unless user.nil?
        genereteSms = GenerateSms.new(params[:acao], params[:periodo])
        sms = genereteSms.generete_sms(params[:child])
        
        sendSms = Sms.new(user.contato, genereteSms.generete_sms(params[:child])) 
        msnSendSuccess = sendSms.sendSmsToApi
        
        
         if msnSendSuccess.status == 200
             if @sms_message.save! && !user.nil? 
               @sms_messages = SmsMessage.where(monitor_user_id: @current_user.id).includes(:monitor_user, :child).order(id: :desc).limit(5)
               render json: @sms_messages, :include => {child: {:only =>[:nome, :contato]},monitor_user: {:only =>[:name]}}, status: :created
             else
               render json: @sms_message.errors, error: "Ops!! ocorreu um error a gravar",status: :unprocessable_entity
             end
            
         else
           render json: @sms_message.errors, error: "Aluno não encontrado",status: :unprocessable_entity
         end      
      end   
    end

    # PATCH/PUT /sms_messages/1
    def update
      if @sms_message.update(sms_message_params)
        render json: @sms_message
      else
        render json: @sms_message.errors, status: :unprocessable_entity
      end
    end

    # DELETE /sms_messages/1
    def destroy
      @sms_message.destroy
    end


     
    

    private
      def getAllSms
        @sms_messages = SmsMessage.allChild(@current_user)
      end
    
      # Use callbacks to share common setup or constraints between actions.
      def set_sms_message
        @sms_message = SmsMessage.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def sms_message_params
        params.require(:sms_message).permit(:monitor_user_id, :child, :user_id, :status, :acao, :perido)
      end
  end
end