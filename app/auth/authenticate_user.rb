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
      return user if !user.nil? && user.authenticate(password)
      
      if user.nil?
        user = MonitorUser.find_by(login: login)
        return user if !user.nil? && user.authenticate(password)        
      end     
            
      return errors.add :user_authentication, 'Dados inválidos'
      nil
    
    end
  end