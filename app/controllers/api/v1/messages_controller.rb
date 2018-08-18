module Api::V1
  class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :update, :destroy]
    
    # GET /messages
    def index
      getAllMessages()

      render json: @messages
    end

    # GET /messages/1
    def show
      render json: @message
    end

    # POST /messages
    def create
      @message = Message.new(message_params)
      @message.user_id = @current_user.id
      if @message.save!
        getAllMessages()
        render json: @messages, status: :created
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /messages/1
    def update
      if @message.update(message_params)
        render json: @message
      else
        render json: @message.errors, status: :unprocessable_entity
      end
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:user_id, :acao, :periodo, :message_text)
      end

      def getAllMessages
        @messages = Message.all
      end
  end
end