class AuthenticateUser
    
    prepend SimpleCommand
    attr_accessor :login, :password    
    
    
    #this is where parameters are taken when the command is called
    def initialize(login, password)
      @login = login
      @password = password
    end
    
    #this is where the result gets returned
    def call     
      if user        
          JsonWebToken.encode(user_id: user.id )      
      end  
    end
  
    private
  
    def user
      user = User.find_by(login: login)
      unless user.nil?
        if user.status == 'ativo' 
            return user if user.authenticate(password)
        else
            return errors.add :user_authentication, 'Acesso não Autorizado, entre em contato com o suporte!'  
        end
      end

      monitor = MonitorUser.find_by(login: login) unless user
      user = monitor
      
      unless monitor.nil?
        if monitor.user.status == 'ativo'           
            return user if  user.authenticate(password)
        else
            return errors.add :user_authentication, 'Acesso não Autorizado, entre em contato com o suporte!'  
        end      
      end

      return errors.add :user_authentication, 'Dados inválidos'
      nil
    
    end
  end