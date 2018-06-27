module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    
    skip_before_action :authenticate_request, only: %i[adminLogin appLogin]   

    def appLogin      
      
      #unless (monitor.nil?)
      if (authenticate params[:login], params[:password])
        
        access_number = MonitorUser.find_by(login: params[:login])
        unless (access_number.nil?)
            if (access_number == 0 )            
              return access_number.access_count
            else 
                access_update = (access_number.access_count + 1)          
                MonitorUser.find_by(login: params[:login]).update(access_count: access_update)          
            end
        end  
              
      end
      
    end
    def adminLogin
      
      if ((authenticate params[:login], params[:password]))
        
        access_number = User.select(:access_count).find_by(login: params[:login])
        access_update = (access_number.access_count + 1)        
        User.find_by(login: params[:login]).update(access_count: access_update)
        
      end  
      
    end
    

    # GET /users
    def index
      @users = User.all

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
      params.permit(:name, :login, :password, :contato, :level, :id)
    end

 
  def authenticate(login, password)    
    
    url =  request.original_fullpath.split('/')  
    
    #if (url[3] === "app")       
      user = MonitorUser.select(:id, :level, :name, :user_id, :access_count).find_by(login: login)
    #else      
      user = User.select(:id, :level, :name, :access_count).find_by(login: login) if user.nil?
    #end
      
    command = AuthenticateUser.call(login, password) 
      
      if command.success?
        if (user.access_count > 0)
          
          render json: {
            id: user.id,
            name: user.name, 
            level: user.level,        
            access_token: command.result,
            message: 'Login realizado com sucesso!'
            
          }
        else 
            render json: {
              id: user.id,
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
