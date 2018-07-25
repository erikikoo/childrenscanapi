class Sms

    require "http"    
   
    def initialize(numero = '', msn= '')
        @numero = numero
        @msn = msn        
    end

    # =============================================================================    
    # TO 360NRS
    #$url = 'https://dashboard.360nrs.com/api/rest/sms' 
    def sendSmsToApi360nrs       
        $data = '{"to":["5511946344764"],"message":"'+@msn+'","from":"'+@emp+'", "notificationUrl":"'+$urlResponse+'"}'
        $data = '{"to":["5511946344764"],"message":"'+@msn+'","from":"'+@emp+'", "encoding": "utf-16", "notificationUrl":"'+$urlResponse+'"}'
        $data = '{"to":["'+formContactNumber+'"],"message":"'+@msn+'","from":"'+@emp+'"}'
        return HTTP.basic_auth(:user => "ErikRdeSouza", :pass => "08121598").post($url, :ssl_context => ctx, :body => $data)
        
        
    end

    # =======================================================================
    #TO OSMS
    $email = 'erikikoo@hotmail.com'
    $senha = 'HayHelena'
    def sendSmsToApiOSMS
        
        $url = "http://smsadmin.ddns.net/sms/url.src"
        # @msn = "teste de envio do app #{Time.now}"
        #?int=send&sms.aplicativo=osms&sms.email="+$email+"&sms.senha="+$senha+"&sms.celular="+formContactNumber(@numero)+"&sms.sms="+@msn 
        sms = HTTP.post($url, :params => { int: 'send', 'sms.aplicativo': 'osms', 'sms.email': $email, 'sms.senha': $senha, 'sms.celular': formContactNumber(@numero), 'sms.sms': @msn})
        
        return sms 
        
    end

    def getSaldoOSMS
        $url = 'http://smsadmin.ddns.net/sms/url.src?int=saldo&aplicativo=osms&email='+$email+'&senha='+$senha
        
        sms = HTTP.post($url)
        return sms.body
    end

    # =======================================================================
    #TO KING_SMS
    $url = "http://sms.kingtelecom.com.br/kingsms/api.php"
    $login = "ErikRdeSouza"
    $token = "f6140de80f9c14cf39e30764f9d0aa2c"
    def sendSmsToApiKingsms
        #Usar para kingsms
        #sendsms
        return HTTP.get($url, :params => {acao: "sendsms", login: $login, token: $token, numero: formContactNumber(@numero), msg: @msn })   
    end

    def getSaldoKingsms
        sms = HTTP.get($url, :params => {acao: "saldo", login: $login, token: $token })
        result = JSON.parse(sms.body)
        return result
    end

# ============================================================================

    private
    def formContactNumber(numero)
       # unless numero.nil?
            numero.gsub(')', '').gsub('(', '').gsub(' ', '').gsub('-', '') 
            #return numberFormat
       # else
       #     return numero
       # end    
    end

end    