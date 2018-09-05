module Api::V1
  class SmsMessagesController < ApplicationController
    before_action :getAllSms, only: [:index, :create]
    before_action :set_sms_message, only: [:show, :update, :destroy]
    #skip_before_action :authenticate_request
    #require 'json'
    # GET /sms_messages
    def index
      #@sms_messages = SmsMessage.includes(:monitor_user, :child).order('created_at DESC')            
      render json: @sms_messages, :include => {child: {:only =>[:contato, :responsavel, :name]},monitor_user: {:only =>[:name]}}
    end

    def app_historico
      #@sms_messages = SmsMessage.where(user_id: @current_user.id).order(id: :desc).limit(5)
      #@sms_messages = SmsMessage.limit(5)
      #if (@current_user.level <= 2) 
        @sms_messages = SmsMessage.where(monitor_user_id: @current_user.id).includes(:monitor_user, :child).order(id: :desc).limit(15)
      
      #end  
      render json: @sms_messages, :include => {child: {:only =>[:name, :contato]},monitor_user: {:only =>[:name]}}
    
    end

    def sms_search
        unless params[:name].nil? || params[:name] == 'undefined' || params[:name] == ''
          search = params[:name]
          child = Child.find_by("name like ?", "%#{search}%")
        
          unless child.nil?
            @sms_messages = SmsMessage.where(monitor_user_id: @current_user.id, child_id: child.id).includes(:monitor_user, :child)        
            render json: @sms_messages, :include => {child: {:only =>[:name, :contato]},monitor_user: {:only =>[:name]}}
          else 
            render json: {status: 204}
          end  
        else 
          @sms_messages = SmsMessage.where(monitor_user_id: @current_user.id).includes(:monitor_user, :child)
          render json: @sms_messages, :include => {child: {:only =>[:name, :contato]},monitor_user: {:only =>[:name]}}
        end
      
    end

    # GET /sms_messages/1
    def show
      render json: @sms_message
    end

    # POST /sms_messages
    def create
      @sms_message = SmsMessage.new(sms_message_params)
      
      monitor = MonitorUser.find(@sms_message.monitor_user_id)
      
      child = Child.find_by(name: params[:child], user_id: monitor.user_id)
      @sms_message.child_id = child.id if child
      
      
       unless child.nil?       
        
          sms_text = Message.find_by(periodo: params[:periodo], acao: params[:acao], user_id: @current_user.id)
          
          unless (sms_text.nil?)
            message = GenerateSms.replace_aluno(sms_text, child)
            sendSms = Sms.new(child.contato, message)
            # sendSms = GenerateSms.replace_aluno(sms_text, child)
          else  
            sendSms = Sms.new(child.contato, GenerateSms.gerar_sms(params[:periodo], params[:acao], params[:child])) 
            # sendSms = GenerateSms.gerar_sms(params[:periodo], params[:acao], params[:child])
          end    
          
          # puts sendSms
          result = sendSms.sendSmsToApiOSMS
          
          if result.status == 200
              
                if @sms_message.save! && !child.nil? 
                    @sms_messages = SmsMessage.where(monitor_user_id: @current_user.id).includes(:monitor_user, :child).order(id: :desc).limit(5)
            
                    render json: @sms_messages, :include => {child: {:only =>[:name, :contato]},monitor_user: {:only =>[:name]}}, status: :created
                else
                    render json: @sms_message.errors, error: "Ops!! ocorreu um error a gravar",status: :unprocessable_entity
                end
          else
                  
                err = CustomHandleError.handleError(result["cause"])               
                render json: {error: err}
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
        if @current_user.level == 3
          @sms_messages = SmsMessage.allChild(@current_user)
        else
          @sms_messages = User.find(@current_user.id).sms_messages#.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current )
        end
      end
    
      # Use callbacks to share common setup or constraints between actions.
      def set_sms_message
        @sms_message = SmsMessage.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def sms_message_params
        params.require(:sms_message).permit(:monitor_user_id, :child, :user_id, :status, :msn, :periodo, :acao)
      end
  end
end