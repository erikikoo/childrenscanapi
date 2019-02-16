module Api::V1
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    skip_before_action :authenticate_request, only: [:index, :show, :getEventCount, :eventRead]
    # GET /events
    def index
      @events = Event.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current ).order(created_at: :DESC)

      render json: @events
    end

    # GET /events/1
    def show
      render json: @event
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        
        getAllEvents
        
        render json: @events, status: :created
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /events/1
    def destroy
      @event.destroy
    end

    def getEventCount      
      @events = getEventsReadPerDevice
     
      render json: @events
    end

    def eventRead      
      id = params[:event][:id]      
      uid = params[:event][:uid]

      device_id = Device.find_by(uid: uid)
      event = EventDevice.find_by(event_id: id, device_id: device_id.id)
      unless event
        if EventDevice.create!(event_id: id, device_id: device_id.id)# if device_id
            @events = getEventsReadPerDevice(uid)
            render json: @events, status: 200 
        else
          render json: {status: :unprocessable_entity}
        end
      end  
    end

    private

      def getEventsReadPerDevice(uid = nil)
        
        if uid
          @device_id = Device.find_by(uid: uid).id 
        else  
          @device_id = Device.find_by(uid: params[:uid]).id 
        end 

        @ev_id = Event.select(:id)      
        val = 0
        @ev_id.each do |evid|
          ev_device = EventDevice.find_by(event_id: evid, device_id: @device_id)
          val = val + 1 if ev_device.nil?
        end
        return val
      end
    

      def getAllEvents
        @events = Event.where(user_id: @current_user.id)
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:title, :message_text, :user_id, :summary)
      end
  end
end