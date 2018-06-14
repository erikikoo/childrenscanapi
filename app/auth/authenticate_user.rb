class AuthenticateUser
    #require 'jwt'
    prepend SimpleCommand
    attr_accessor :login, :password    
    
    
    #this is where parameters are taken when the command is called
    def initialize(login, password)
      @login = login
      @password = password
    end
    
    #this is where the result gets returned
    def call
      #user_id: user.id
      if user  
        #if user != nil
          JsonWebToken.encode(user_id: user.id )
        #else 
        #  JsonWebToken.encode(user_id: monitor.id )
        #end
      end  
    end
  
    private
  
    def user
      
      user = User.find_by(login: login)            
      return user if !user.nil? && user.authenticate(password)
      
      if user.nil?
        user = MonitorUser.find_by(login: login)
        return user if !user.nil? && user.authenticate(password)        
      end
      #user = MonitorUser.find_by(login: login)          
      #return user if user && user.authenticate(password)
            
      return errors.add :user_authentication, 'Dados inválidos'
      nil
    
    end
  end