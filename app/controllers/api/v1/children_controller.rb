module Api::V1
  class ChildrenController < ApplicationController
    
    before_action :set_child, only: [:destroy, :update_status, :show]    
    before_action :getAllChildren, only: [:index, :destroy, :generate_qr_code]
    skip_before_action :authenticate_request, only: [:getChildrenPerUidDevice, :create, :show, :update, :send_code]
    
    # GET /children
    def index      
        render json: @children
      # end
    end

    def getChildrenPerUidDevice
      
      find_child_per_device(params[:uid])
      
      render json:  @children,:include => {:user => {:only => :name}}
      
    end

    # GET /children/1
    def show      
      render json: @child, :include => {:user => {:only => :name}, :escola => {:only => :nome}, :mensalidades => {:only => :mes}}
    end

    # POST /children
    def create
      
        @child = Child.new(child_params)
        @child.name = @child.name.downcase.squish
        
        if child_params[:devices_attributes].present?
          $_device_attributes = child_params[:devices_attributes][0]
          params_uid_oneseignal = $_device_attributes[:uid_onesignal]
          params_uid_device = $_device_attributes[:uid_device]
        end
        
        #verifica se existe a criança
        checkChild = CheckChild.existChildPerNameAndNasc?(@child.name, @child.nascimento) 
        #se existir criança
      if checkChild && $_device_attributes
          #checa se existe o device
          device = CheckDevice.existDevicePerUid?(params_uid_oneseignal)
          unless device
            # checkDevice = Device.find_by(uid: @child.devices_attributes[:uid])
            #se exitir a criança cadastrada e não existir o device cadastrado cria o device       
            
            #cria o device
            device = Device.create!(uid_onesignal: params_uid_oneseignal, uid_device: params_uid_device )
            
            #o relaciona com a crianca
            DeviceChild.create!(device_id: device.id, child_id: checkChild.id)

            find_child_per_device(device.uid_onesignal)

            render json: {device_id: device.uid_onesignal, status: :created,  message: 'Dispositivo cadastrado com sucesso!'}
          else
            DeviceChild.create!(device_id: device.id, child_id: checkChild.id)
            render json: {status: :unprocessable_entity, message: 'Dispositivo e/ou Criança cadastrados!'}
          end

      elsif $_device_attributes

          #se existir o dispositivo
          device = CheckDevice.existDevicePerUid?(params_uid_oneseignal)
          
          if device
            child = child_creating @child
                          
              if child
                
                DeviceChild.create!(device_id: device.id, child_id: child.id)
                
                render json: {device_id: device.uid_onesignal, status: :created,  message: 'Criança cadastrado com sucesso!'}

              else

                render json: child.errors, status: :unprocessable_entity, message: 'Ops, erro ao cadastrar esta criança'

              end    
          else
            # @child.user_id = 1
            @child.uid = GenerateUid.generate
            if child_creating              
              # @children = Child.last
              render json: {device_id: params_uid_oneseignal, status: :created,  message: 'Aluno e dispositivo cadastrado com sucesso!'}
            else                    
              render json: @child.errors, status: :unprocessable_entity, message: 'Ops, error ao cadastrar esta criança e dispositivo'
            end
          end
      elsif checkChild
        render json: {status: :unprocessable_entity, message: 'Esta criança já possui cadastro'}
      else
          child = child_creating @child
          
          # @child.code = GenerateUid.generate_code
            # puts "=========================="
            # puts @child.name
            # puts @child.responsavel
            # puts @child.custom_uid
            # puts "=========================="
            if child_creating(@child)
              render json: {status: :created,  message: 'Criança cadastrado com sucesso!'}   
            else
              render json: child.errors, status: :unprocessable_entity, message: 'Ops, erro ao cadastrar esta criança'
            end
        end
        
       
    end

    # PATCH/PUT /children/1
    def update
      # params_uid_oneseignal = child_params[:devices_attributes][0][:uid_onesignal]
      # params_child = {name: child_params[:name], contato: child_params[:contato], nascimento: child_params[:nascimento], responsavel: child_params[:responsavel], sexo: child_params[:sexo], user_id: child_params[:user_id]}
      @child = Child.find(params[:id])
      if @child.update(child_params)
        
        # find_child_per_device(params_uid_oneseignal)
        
        render json: {children: @children, message: 'Aluno atualizado com sucesso!'}
        

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

    def send_code
        $_message = ''
        $_code = params[:code]
        $_params_uid_device = params[:uid_device]        
        $_params_uid_oneseignal = params[:uid_onesignal]
        
        $_child = Child.find_by(code: $_code)
        $_device = CheckDevice.existDevicePerUid? $_params_uid_oneseignal if $_params_uid_oneseignal

        if $_params_uid_oneseignal && $_params_uid_device
          if $_child
              if $_device
                
                _exist_child = false
                
                $_device.children.each do |child|
                  child.id == $_child.id ? _exist_child = true : _exist_child = false
                end
                
                #o relaciona com a crianca
                unless _exist_child
                  DeviceChild.create!(device_id: $_device.id, child_id: $_child.id)
                  $_message = 'Dispositivo relacionado com sucesso!'
                else
                  $_message = 'Dispositivo já cadastrado!'
                end
              elsif !$_device
                #cria o device
                $_device = Device.create!(uid_onesignal: $_params_uid_oneseignal, uid_device: $_params_uid_device )
                DeviceChild.create!(device_id: $_device.id, child_id: $_child.id)
                $_message = 'Dispositivo adicionado e relacionado com sucesso!'
              end

              find_child_per_device($_device.uid_onesignal)
              
              render json: {message: $_message}
          else
              render json: {message: 'Código inválido, entre em contato com seu transporte escolar'}
          end
        else
            render json: {message: "Ops! Ocorreu um erro, perda de parametros"}
        end
        
    end


    private

   def child_creating child
    $_child = Child.create!(name: child.name, contato: child.contato ,nascimento: child.nascimento, responsavel: child.responsavel, sexo: child.sexo, user_id: child.user_id, uid: GenerateUid.generate, venc: child.venc, escola_id: child.escola_id, code: GenerateUid.generate_code, custom_uid: child.custom_uid)
    return $_child
   end


    def find_child_per_device(uid)
      device = Device.find_by(uid_onesignal: uid)
      # d = Device.find_by(uid_onesignal: "9a7d889d-cddd-41c2-8c43-b478fac418f7")
      # d = Device.find_by(uid_onesignal: "9a7d889d-cddd-41c2-8c43-b478fac418f7")
      if device
        @children = device.children.map do |d|          
          d.attributes.merge(notificationTotal: Notification.countNotification(d.id))
        end 
        return @children
      end
    end  
      
    def getAllChildren     
      
      if (@current_user.level == 3) 
        @children = Child.all.order(user_id: :asc)
      else 
        @children = Child.includes(:user, :escola).where(user_id: @current_user)
      end        
      @children = @children.map do |child|        
          
        {
          id: child.id,
          name: child.name,
          responsavel: child.responsavel,
          user: {name: child.user.name},
          code: child.code,
          user_id: child.user_id,
          last_mensalidade: child.mensalidades.maximum('mes')
        }
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
     
      def get_child
        @child = Child.where(id: params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def child_params       
        
        params.require(:child).permit(:name, 
                                      :contato, 
                                      :nascimento, 
                                      :responsavel, 
                                      :sexo, 
                                      :status, 
                                      :venc, 
                                      :user_id,
                                      :id, 
                                      :escola_id, 
                                      :custom_uid,
                                      :tipo_viagem, 
                                      :created_at, 
                                      :updated_at, 
                                      devices_attributes: [:uid_onesignal, :uid_device] )
      end
  end
end

#, notification_devices_attributes: [:device_id] )