module Api::V1
  class MonitorUsersController < ApplicationController
    before_action :set_monitor_user, only: [:update, :destroy]
    before_action :getAllMonitor, only: [:index]
    before_action :set_monitor_with_user_data, only: [:show]
    #before_action :authenticate_request
    # GET /monitor_users
    def index
      #@monitor_users = MonitorUser.where(user_id: @current_user.id).includes(:user).order('id DESC')

      render json: @monitor_users, :include => {:user => {:only => :name}}
    end

    # GET /monitor_users/1
    def show
      render json: @monitor_user, :include => {:user => {:only => :name}}
    end

    # POST /monitor_users
    def create
      @monitor_user = MonitorUser.new(monitor_user_params)

      if @monitor_user.save!
        render json: @monitor_user, status: :created
      else
        render json: @monitor_user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /monitor_users/1
    def update
      #password_digest = monitor_user_params.password_digest
      @monitor_user.password = monitor_user_params[:password_digest]
      @monitor_user.password_confirmation = monitor_user_params[:password_digest]
      #@monitor_user.update(monitor_user_params)#
      if @monitor_user.save!
        #num = @monitor_user.access_count.to_i + 1
        #@monitor_user.update(access_count: num)
        render json: @monitor_user
      else
        render json: @monitor_user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /monitor_users/1
    def destroy
      @monitor_user.destroy
    end

    private
      def getAllMonitor
        @monitor_users = MonitorUser.allMonitor(@current_user)
      end
    
    # Use callbacks to share common setup or constraints between actions.
      def set_monitor_user
        @monitor_user = MonitorUser.find(params[:id])
      end

      def set_monitor_with_user_data
        @monitor_user = MonitorUser.includes(:user).find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def monitor_user_params
        params.require(:monitor_user).permit(:login, :name, :password_digest, :user_id, :level)
      end
  end
end