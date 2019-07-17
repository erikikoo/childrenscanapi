module Api::V1
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :update, :destroy]
    skip_before_action :authenticate_request, only: [:app_responsavel_show_events, :app_transporte_show_events ,:show, :getEventCount, :eventRead, :create]
    # GET /events
    def index          
      @events = Event.where(user_id: @current_user).order(created_at: :DESC)
      render json: @events
    end

    def app_responsavel_show_events
       # ==> app resp
      uid_device = params[:uid_device]
            
      device = Device.find_by(uid_device: uid_device)
      
      @events = Event.where(user_id: device.children[0].user_id).order(created_at: :DESC) if device && device.children
      
      render json: @events
    end

    def app_transporte_show_events
      @events = []
      
      user_id = MonitorUser.find(params[:monitor_id]).user_id      
      
      $_events = Event.where(user_id: user_id) if user_id
   
      $_events.each do |event|
        _image_url = getCloudinaryUrl(event)
        @events << {id: event.id, message_text: event.message_text, summary: event.summary, title: event.title, user_id: event.user_id, image: _image_url }
      end
      render json: @events
    end

    # GET /events/1
    def show
      getChildSubscribeInTheEvent(@event.id, @current_user)
      
      _image_url = getCloudinaryUrl(@event)
      
      
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
  
      if @event.save!
        
        unless params[:event][:image].blank?
          $_cloudinary_image = Cloudinary::Uploader.upload(params[:event][:image])
          if $_cloudinary_image
            $_event_created = Event.find(@event.id)         
            
            $_event_created.update(cloudinary_url: $_cloudinary_image['secure_url'].to_s, cloudinary_public_id: $_cloudinary_image['public_id'])
          else
            $_event_created.destroy
          end
        end  
        # @event.image.attach(params[:event][:image]) unless params[:event][:image].blank?
       
          
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
      img = Cloudinary::Uploader.destroy(@event.cloudinary_public_id)
           
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

    def getCloudinaryUrl event
      event.cloudinary_url.nil? ? _image_url = nil  : _image_url = url_for(event.cloudinary_url)
      return _image_url
    end

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
        params.require(:event).permit(:title, :message_text, :user_id, :summary, :cloudinary_url)
      end
  end
end