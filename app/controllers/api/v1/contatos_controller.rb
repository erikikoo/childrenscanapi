module Api::V1
  class ContatosController < ApplicationController
    before_action :set_contato, only: [:update, :destroy]

    # GET /contatos
    def index
      @contatos = Contato.all

      render json: @contatos
    end

    # GET /contatos/1
    def show
      getLastContact()
      render json: @contato
    end

    # POST /contatos
    def create
      @contato = Contato.new(contato_params)
      
      cont = Contato.last  
      
      if cont 
        if cont.update(contato_params)
          render json: cont, status: :created
        else
          render json: @cont.errors, status: :unprocessable_entity
        end
      elsif !cont
        if @contato.save
          render json: @contato, status: :created 
        else
          render json: @contato.errors, status: :unprocessable_entity
        end
      end     
    end

    # PATCH/PUT /contatos/1
    def update
      if @contato.update(contato_params)
        
        # getLastContact()
        
        render json: @contato
      else
        render json: @contato.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contatos/1
    def destroy
      @contato.destroy
    end

    private

      def getLastContact
        @contato = Contato.last
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_contato
        @contato = Contato.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contato_params
        params.require(:contato).permit(:telefone, :email, :url)
      end
  end
end
