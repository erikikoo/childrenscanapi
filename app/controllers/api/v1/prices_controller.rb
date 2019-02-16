module Api::V1
  class PricesController < ApplicationController
    before_action :set_price, only: [:show, :update, :destroy]

    # GET /prices
    def index
      @prices = Price.all.includes(:user)

      render json: @prices, :include => {:user => {:only => :name}} 
    end

    # GET /prices/1
    def show
      render json: @price
    end

    # POST /prices
    def create
      @price = Price.new(price_params)

      if @price.save
        getAllPrices()
        render json: @prices, status: :created
      else
        render json: @price.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /prices/1
    def update
      if @price.update(price_params)
        getAllPrices()
        render json: @prices, :include => {:user => {:only => :name}} 
      else
        render json: @price.errors, status: :unprocessable_entity
      end
    end

    # DELETE /prices/1
    def destroy
      @price.destroy
      getAllPrices()
      render json: @prices, :include => {:user => {:only => :name}} 
    end

    private
      def getAllPrices
        @prices = Price.all.includes(:user)
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_price
        @price = Price.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def price_params
        params.require(:price).permit(:value, :user_id, :date_current)
      end
  end
end  
