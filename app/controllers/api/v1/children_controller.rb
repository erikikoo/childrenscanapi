module Api::V1
  class ChildrenController < ApplicationController
    # before_action :authenticate_request
    before_action :set_child, only: [:show, :destroy, :update_status]
    # before_action :getAllChildren, only: [:index, :create, :destroy, :generate_qr_code]
    before_action :getAllChildren, only: [:index, :destroy, :generate_qr_code]
    skip_before_action :authenticate_request, only: [:getChildrenPerUidDevice, :create, :show, :update]
    
    # GET /children
    def index
      # if params[:uid] != 'undefined'         
      #   find_child_per_device(params[:uid]) 
        
        render json: @children, :include => {:user => {:only => :name}}      
      # end
    end

    def getChildrenPerUidDevice
      # if params[:uid] != 'undefined' 
      find_child_per_device(params[:uid])
      
      render json:  @children,:include => {:user => {:only => :name}}
      # end
    end

    # GET /children/1
    def show
      render json: @child, :include => {:user => {:only => :name}}
    end

    # POST /children
    def create
      
        @child = Child.new(child_params)           
        @child.name = @child.name.downcase
         
        params_uid_oneseignal = child_params[:devices_attributes][0][:uid_onesignal]
        params_uid_device = child_params[:devices_attributes][0][:uid_onesignal]
        #verifica se existe a criança
        
        checkChild = CheckChild.existChildPerNameAndNasc?(@child.name, @child.nascimento) 
        #se existir criança
        if checkChild
          
          #checa se existe o device
          unless CheckDevice.existDevicePerUid?(params_uid_oneseignal)
            # checkDevice = Device.find_by(uid: @child.devices_attributes[:uid])
            #se exitir a criança cadastrada e não existir o device cadastrado cria o device       
            
            #cria o device
            device = Device.create!(uid_onesignal: params_uid_oneseignal, uid_device: params_uid_device )
            
            #o relaciona com a crianca
            DeviceChild.create!(device_id: device.id, child_id: checkChild.id)

            find_child_per_device(device.uid_onesignal)

            render json: {device_id: device.uid_onesignal, status: :created,  message: 'Dispositivo cadastrado com sucesso!'}
          else
            render json: {status: :unprocessable_entity, message: 'Dispositivo já cadastrado!'}
          end

        else

          #se existir o dispositivo
          device = CheckDevice.existDevicePerUid?(params_uid_oneseignal)
          if device
             
              child = Child.create!(name: @child.name, contato: @child.contato ,nascimento: @child.nascimento, responsavel: @child.responsavel, sexo: @child.sexo, user_id: @child.user_id, uid: GenerateUid.generate)
              
              if child
                
                DeviceChild.create(device_id: device.id, child_id: child.id)
                
                render json: {device_id: device.uid_onesignal, status: :created,  message: 'Criança cadastrado com sucesso!'}

              else

                render json: child.errors, status: :unprocessable_entity, message: 'Ops, erro ao cadastrar esta criança'

              end    
          else
            # @child.user_id = 1
            if @child.save!              
              # @children = Child.last
              render json: {device_id: params_uid_oneseignal, status: :created,  message: 'Aluno e dispositivo cadastrado com sucesso!'}
            else                    
              render json: @child.errors, status: :unprocessable_entity, message: 'Ops, error ao cadastrar esta criança e dispositivo'
            end
          end
          
        end
       
    end

    # PATCH/PUT /children/1
    def update
      params_uid_oneseignal = child_params[:devices_attributes][0][:uid_onesignal]
      params_child = {name: child_params[:name], contato: child_params[:contato], nascimento: child_params[:nascimento], responsavel: child_params[:responsavel], sexo: child_params[:sexo], user_id: child_params[:user_id]}
      @child = Child.find(params[:id])
      if @child.update(params_child)
        
        find_child_per_device(params_uid_oneseignal)
        
        render json: {children: @children, uid: params_uid_oneseignal, message: 'Aluno atualizado com sucesso!'}
        # render json: @children, message: 'Aluno atualizado com sucesso!'

      else
        render json: @child.errors, status: :unprocessable_entity
      end
    end

    # DELETE /children/1
    def destroy
      @child.destroy
    end

    def generate_qr_code      
      getAllChildrenOfUser(params[:id])
      render json: @children, :include => {:user => {:only => [:id, :uid]}} 
    end

    def update_status
      if @child.status == 'ativo'
        @child.update(status: 0)
      elsif @child.status == 'desativado'
        @child.update(status: 1)
      end    
      if @child.save!
        getAllChildren()
        render json: @children, :include => {:user => {:only => :name}}
      else
        render json: @children.errors, status: :unprocessable_entity
      end
    end


    private


    def find_child_per_device(uid)
      device = Device.find_by(uid_onesignal: uid)
      if device
        @children = device.children.map do |d|          
          d.attributes.merge(notificationTotal: Notification.countNotification(d.id))
        end 
        return @children
      end
    end  
      
    def getAllChildren
      #monitor = User.find(@current_user)
      if (@current_user.level == 3) 
        @children = Child.all.order(user_id: :asc)
       else 
        @children = Child.where(user_id: @current_user)
       end
    end
    
    def getAllChildrenOfUser(id='')
      unless id
        @children = Child.where(user_id: @current_user)
      else
        @children = Child.where(user_id: id)
      end
    end  
    # Use callbacks to share common setup or constraints between actions.
      def set_child
        @child = Child.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def child_params       
        
        params.require(:child).permit(:name, :contato, :nascimento, :responsavel, :sexo, :status, :user_id, :id, :created_at, :updated_at, devices_attributes: [:uid_onesignal, :uid_device] )
      end
  end
end

#, notification_devices_attributes: [:device_id] )