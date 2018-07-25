module Api::V1
  class TicketsController < ApplicationController
    before_action :set_ticket, only: [:show, :update, :destroy]
    before_action :getAllTickets, only: [:index, :update]
    # GET /tickets
    def index
      render json: @tickets, :include => {user: {:only =>[:name]}}
    end

    # GET /tickets/1
    def show
      Answer.where(ticket_id: params[:id]).update(status: :visualizado)
      render json: @ticket, :include => {user: {:only =>[:name]}, answers: {:only =>[:answer, :created_at]}}
    end

    # POST /tickets
    def create
      @ticket = Ticket.new(ticket_params)

      if @ticket.save!
        getAllTickets()
        render json: @tickets, status: :created, :include => {user: {:only =>[:name]}, answers: {:only =>[:answer]}}
      else
        render json: @ticket.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tickets/1
    def update
      if @ticket.update(ticket_params)
        render json: @tickets, :include => {user: {:only =>[:name]}, answers: {:only =>[:answer]}}
      else
        render json: @ticket.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tickets/1
    def destroy
      @ticket.destroy
    end

    def total
      if @current_user.level === 3
        ticket = Ticket.where(status: 1).count
        render json: ticket
      else
        ticket = Ticket.joins("INNER JOIN answers ON answers.ticket_id = tickets.id AND answers.status = '0'").count
        render json: ticket
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_ticket
        @ticket = Ticket.includes(:user, :answers).find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def ticket_params
        params.require(:ticket).permit(:user_id, :status, :notification, :title)
      end

      def getAllTickets
        if @current_user.level == 3
          @tickets = Ticket.includes(:user).order(created_at: :desc)
        else  
          @tickets = Ticket.includes(:user).where(user_id: @current_user.id)
        end  
      end
  end
end