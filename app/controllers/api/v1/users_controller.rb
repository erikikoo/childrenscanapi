module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy, :update_status]
    
    skip_before_action :authenticate_request, only: %i[adminLogin appLogin]   

    def appLogin
      
      authenticate params[:login], params[:password]      
      
    end
    
    def adminLogin
      
       authenticate params[:login], params[:password]         
       
    end
    

    # GET /users
    def index
      get_all_users

      render json: @users
    end

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    def create
      @user = User.new(user_params)

      if @user.save!
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update_status
      if @user.status == 'ativo'
        @user.update(status: 0)
      elsif @user.status == 'desativado'
        @user.update(status: 1)
      end    
      if @user.save!
        get_all_users
        render json: @users
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end


    # DELETE /users/1
    def destroy
      @user.destroy
    end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :login, :password, :contato, :level, :id, :user )
    end

    def get_all_users
      @users = User.where.not(level: 3).order(:id)
    end
 
  def authenticate(login, password)    

      user = MonitorUser.find_by(login: login)

      user.nil? ? $isMonitor = false : $isMonitor = true

      user = User.find_by(login: login) if user.nil?       
      
      command = AuthenticateUser.call(login, password)      

      
        if command.success? 
            url =  request.original_fullpath.split('/')          
            
            access_update = (user.access_count + 1)  

            if (url[3] === "app")                 
              MonitorUser.find(user.id).update(access_count: access_update) if user
            else                
              User.find(user.id).update(access_count: access_update) if user
            end
            
            
            if $isMonitor
            
                render json: {
                      id: user.id,
                      user_id: user.user_id, 
                      name: user.name, 
                      level: user.level,        
                      access_token: command.result,
                      message: 'Login realizado com sucesso!',
                      access_number: user.access_count
                  }             
            else 
              render json: {
                      id: user.id,
                      # user_id: $user_id, 
                      name: user.name, 
                      level: user.level,        
                      access_token: command.result,
                      message: 'Login realizado com sucesso!',
                      access_number: user.access_count
                  }             
            end
        else        
          render json: { error: command.errors }, status: :unauthorized
        end
      
    end   
  end
end
