class MensalidadesController < ApplicationController
  before_action :set_mensalidade, only: [:show, :update, :destroy]

  # GET /mensalidades
  def index
    @mensalidades = Mensalidade.all

    render json: @mensalidades
  end

  # GET /mensalidades/1
  def show
    render json: @mensalidade
  end

  # POST /mensalidades
  def create
    @mensalidade = Mensalidade.new(mensalidade_params)

    if @mensalidade.save
      render json: @mensalidade, status: :created, location: @mensalidade
    else
      render json: @mensalidade.errors, status: :unprocessable_entity
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
    @mensalidade.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mensalidade
      @mensalidade = Mensalidade.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mensalidade_params
      params.require(:mensalidade).permit(:user_id, :child, :status)
    end
end
