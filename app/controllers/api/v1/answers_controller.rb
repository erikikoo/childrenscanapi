module Api::V1
  class AnswersController < ApplicationController
    before_action :set_answer, only: [:show, :update, :destroy]

    # GET /answers
    def index
      @answers = Answer.all

      render json: @answers
    end

    # GET /answers/1
    def show
      render json: @answer
    end

    # POST /answers
    def create
      @answer = Answer.new(answer_params)
      if @answer.save        
        @ticket = Ticket.includes(:user, :answers).find(@answer.ticket_id)
        # Ticket.includes(:user, :answers).find(2)
        render json: @ticket, :include => {user: {:only =>[:name]}, answers: {:only =>[:answer, :created_at]}}, status: :created
      else
        render json: @answer.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /answers/1
    def update
      if @answer.update(answer_params)
        render json: @answer
      else
        render json: @answer.errors, status: :unprocessable_entity
      end
    end

    # DELETE /answers/1
    def destroy
      @answer.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_answer
        @answer = Answer.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def answer_params
        params.require(:answer).permit(:ticket_id, :answer, :status)
      end
  end
end