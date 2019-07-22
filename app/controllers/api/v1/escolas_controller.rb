module Api::V1
  class EscolasController < ApplicationController
    before_action :set_escola, only: [:show, :update, :destroy]
    before_action :getAllEscolasPerUser, only: [:destroy, :create]
    
    skip_before_action :authenticate_request, only: [:app_get_escolas]
    # GET /escolas
    def index
      if @current_user.level === 3
        @escolas = Escola.all      
      end
      render json: @escolas
    end

    def app_get_escolas      
      @escolas = Escola.select(:id, :nome).where(user_id: params[:user_id])
      render json: @escolas
    end


    # GET /escolas/1
    def show
      render json: @escola
    end

    # POST /escolas
    def create
      @escola = Escola.new(escola_params)

      if @escola.save
        render json: @escolas, status: :created
      else
        render json: @escola.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /escolas/1
    def update
      if @escola.update(escola_params)
        render json: @escolas
      else
        render json: @escola.errors, status: :unprocessable_entity
      end
    end

    # DELETE /escolas/1
    def destroy
      @escola.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_escola
        @escola = Escola.find(params[:id])
      end

      def getAllEscolasPerUser
        @escolas = Escola.where(user_id: params[:user_id])
      end

      # Only allow a trusted parameter "white list" through.
      def escola_params
        params.require(:escola).permit(:nome, :user_id)
      end
  end
end
