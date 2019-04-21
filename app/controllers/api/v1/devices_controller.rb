module Api::V1
    class DevicesController < ApplicationController
        skip_before_action :authenticate_request, only: [:create, :show]
        def create
            #cria o device            
            device = Device.create!(uid_onesignal: params[:device][:uid_onesignal], uid_device: params[:device][:uid_device])
            render json: {status: :created, location: device}
        end

        def show
            @device = Device.find_by(uid_device: params[:uid])
            render json: @device
        end
    end
end
