module Api::V1
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    skip_before_action :authenticate_request, only: [:app_responsavel_show_events, :app_transporte_show_events ,:show, :getEventCount, :eventRead, :create]
    # GET /events
    def index
      # @events = Event.where("created_at >= ? AND created_at <= ?", Time.current.beginning_of_month, Time.current ).order(created_at: :DESC)
          
      @events = Event.where(user_id: @current_user).order(created_at: :DESC)
      render json: @events
    end

    def app_responsavel_show_events
       # ==> app resp
      uid_device = params[:uid_device]
            
      device = Device.find_by(uid_device: uid_device)
      
      @events = Event.where(user_id: device.children[0].user_id).order(created_at: :DESC) if device
      
      render json: @events
    end

    def app_transporte_show_events
      user_id = MonitorUser.find(params[:monitor_id]).user_id
      # user_id = MonitorUser.find(1).user_id
      
      @events = Event.where(user_id: user_id) if user_id
      
      render json: @events
    end

    # GET /events/1
    def show
      getChildSubscribeInTheEvent(@event.id, @current_user)
      
      @event.image.attached? ? _image_url = url_for(@event.image) : _image_url = nil
      
      event = {id: @event.id, message_text: @event.message_text, summary: @event.summary, title: @event.title, user_id: @event.user_id, child_subscribe_in_event: @child_count ,image: _image_url }
      
      if params[:uid].present? && params[:id].present?
        eventRead(params[:uid], params[:id])
      end  
      render json: event
    end

    # POST /events
    def create
      if (params[:event][:image] != '')
        @event = Event.new(event_params)      
      else 
        @event = Event.new(params.require(:event).permit(:title, :message_text, :user_id, :summary))
      end
      # debugger
       if @event.save!
       
        @event.image.attach(params[:event][:image]) unless params[:event][:image].blank?
       
          
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
      @image = ActiveStorage::Attachment.find(@event.id)
      if @image.image.attached?
        @image.purge
      end
      @event.destroy
      
    end

    def getEventCount      
      @events = getEventsReadPerDevice(params[:uid])
      
      render json: @events
    end

    def getChildSubscribeInTheEvent(event_id, user_id)
      # @child_count = EventChild.where(event_id: event_id, user_id: user_id).count
      @child_count = EventChild.where(event_id: event_id).count
    end

    
    private
    def eventRead(uid, id)
      
      device_id = Device.find_by(uid_onesignal: uid)
      
      event = EventDevice.find_by(event_id: id, device_id: device_id.id) if device_id
      
      unless event
        EventDevice.create!(event_id: id, device_id: device_id.id)        
      end
      return true  
    end
    
      def getEventsReadPerDevice(uid = nil)
        
        if uid
          @device_id = Device.find_by(uid_onesignal: uid) 
        else  
          @device_id = Device.find_by(uid_onesignal: params[:uid])
        end 

        @ev_id = Event.select(:id)      
        val = 0
        
        if @device_id and @ev_id
          @ev_id.each do |evid|
            ev_device = EventDevice.find_by(event_id: evid, device_id: @device_id.id)
            val = val + 1 if ev_device.nil?
          end
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
        params.require(:event).permit(:title, :message_text, :user_id, :summary, :image)
      end
  end
end