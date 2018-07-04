module Api::V1
  class ApplicationController < ActionController::API
      before_action :authenticate_request
      attr_accessor :current_user
      
      include ExceptionHandler

      # [...]
      private
      def authenticate_request        
        @current_user = AuthorizeApiRequest.call(request.headers).result    
        puts @current_user.level 
        render json: { error: 'Acesso negado!' }, status: 401 unless @current_user
      end  
      
      
  end
end