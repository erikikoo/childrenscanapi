class JsonWebToken
    # our secret key to encode our jwt
    $secret = "4d1918c24396295d06d4df7bb9485fb1ba78c4953f78061369bf0bf853703738f02f632061cba55c
    1cc37028c46617e310169692363bcf97882125e99e5a6845"
      class << self
        def encode(payload, exp = 6.hours.from_now)
          # set token expiration time 
          payload[:exp] = exp.to_i
          
           # this encodes the user data(payload) with our secret key
          JWT.encode(payload, $secret)
        end
    
        def decode(token)
          #decodes the token to get user data (payload)
          body = JWT.decode(token, $secret)[0]
          HashWithIndifferentAccess.new body
    
        # raise custom error to be handled by custom handler
        rescue JWT::ExpiredSignature, JWT::VerificationError => e
          raise ExceptionHandler::ExpiredSignature, e.message
        rescue JWT::DecodeError, JWT::VerificationError => e
          raise ExceptionHandler::DecodeError, e.message
        end
      end
    end