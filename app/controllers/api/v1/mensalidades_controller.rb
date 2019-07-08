module Api::V1
  class MensalidadesController < ApplicationController
    before_action :set_mensalidade, only: [:show, :update]
    skip_before_action :authenticate_request, only: [:app_get_mensalidades]
    # GET /mensalidades
    def index
      @mensalidades = Mensalidade.where(user_id: params[:user_id], child_id: params[:child_id])

      render json: @mensalidades
    end

    def app_get_mensalidades
      @mensalidades = Mensalidade.where(child_id: params[:child_id])
      render json: @mensalidades
    end

    # GET /mensalidades/1
    def show
      render json: @mensalidade
    end

    # POST /mensalidades
    def create
      @mensalidade = Mensalidade.new(mensalidade_params)
      mes = Mensalidade.where(user_id: @mensalidade.user_id, child_id: @mensalidade.child_id, mes: @mensalidade.mes)
      
       if mes.length == 0 
        
        if @mensalidade.save       
          if params[:target]
            redirect_to api_v1_children_path
          else
            getMensalidadePerUser(@mensalidade.user_id, @mensalidade.child_id)
            render json: @mensalidades, status: :created
          end  
        else
          render json: @mensalidade.errors, status: :unprocessable_entity
        end

      end
    end

    # PATCH/PUT /mensalidades/1
    def update
      if @mensalidade.update(mensalidade_params)
        render json: @mensalidade
      else
        render json: @mensalidade.errors, status: :unprocessable_entity
      end
    end

    # DELETE /mensalidades/1
    def destroy
      @mensalidade = Mensalidade.find_by(child_id: params[:child_id], mes: params[:mes], user_id: @current_user.id)
      @mensalidade.destroy
      getMensalidadePerUser(@current_user.id, params[:child_id])

      render json: @mensalidades
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_mensalidade
        @mensalidade = Mensalidade.find(params[:id])
      end

      def getMensalidadePerUser user_id, child_id
        @mensalidades = Mensalidade.where(user_id: user_id, child_id: child_id)
      end

      # Only allow a trusted parameter "white list" through.
      def mensalidade_params
        params.require(:mensalidade).permit(:user_id, :child_id, :status, :mes, :target)
      end
  end
end