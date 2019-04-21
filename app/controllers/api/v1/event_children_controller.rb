module Api::V1
  class EventChildrenController < ApplicationController
    before_action :set_event_child, only: [:show, :update, :destroy]
    skip_before_action :authenticate_request, only: [:create]
    # GET /event_children
    def index
      @event_children = EventChild.all

      render json: @event_children
    end

    # GET /event_children/1
    def show
      render json: @event_child
    end

    # POST /event_children
    def create
      @event_child = EventChild.new(event_child_params)      
      
      params[:event_child][:child_id].each do |child|
       
        check = EventChild.find_by(child_id: child)
        unless check
          EventChild.create!(event_id: @event_child.event_id, child_id: child)        
        end
      end

      render json: {message: "Cadastrado com sucesso!", status: :created }
      
    end

    # PATCH/PUT /event_children/1
    def update
      if @event_child.update(event_child_params)
        render json: @event_child
      else
        render json: @event_child.errors, status: :unprocessable_entity
      end
    end

    # DELETE /event_children/1
    def destroy
      @event_child.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event_child
        @event_child = EventChild.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_child_params
        params.require(:event_child).permit(:event_id, child_id: [])
      end
  end
end