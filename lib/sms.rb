class Sms

    require "http"    
    
    $url = "http://sms.kingtelecom.com.br/kingsms/api.php"
    #http://sms.kingtelecom.com.br/kingsms/api.php?acao=sendsms&login=seulogin&token=b6cdf27e00bbdac2514fa933a52336eb&numero=11999999999&msg=teste
    #$url = 'https://dashboard.360nrs.com/api/rest/sms'    
    $login = "ErikRdeSouza"
    $token = "f6140de80f9c14cf39e30764f9d0aa2c"
    #$urlResponse = 'https://childrenscanapi.herokuapp.com/api/v1/notifica?estado=%d'
    $data = ""
    
    def initialize(numero = '', msn= '')
        @numero = numero
        @msn = msn        
    end

    def sendSmsToApi
        # Usar para 360nrs
        #ctx = OpenSSL::SSL::SSLContext.new
        #ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
        #$data = '{"to":["5511946344764"],"message":"'+@msn+'","from":"'+@emp+'", "notificationUrl":"'+$urlResponse+'"}'
        #$data = '{"to":["5511946344764"],"message":"'+@msn+'","from":"'+@emp+'", "encoding": "utf-16", "notificationUrl":"'+$urlResponse+'"}'
        #$data = '{"to":["'+formContactNumber+'"],"message":"'+@msn+'","from":"'+@emp+'"}'
        #return HTTP.basic_auth(:user => "ErikRdeSouza", :pass => "08121598").post($url, :ssl_context => ctx, :body => $data)
        
        #Usar para kingsms
        return HTTP.get($url, :params => {acao: "sendsms", login: $login, token: $token, numero: formContactNumber, msg: @msn })   
    end

    def getSaldo
        saldo = HTTP.get($url, :params => {acao: "saldo", login: $login, token: $token })   
        return saldo
    end


    private
    def formContactNumber
        unless @numero.nil?
            number = @numero.gsub(')', '').gsub('(', '').gsub(' ', '').gsub('-', '') 
            return numberFormat = "55#{number}"
        else
            return @numero
        end    
    end

end    