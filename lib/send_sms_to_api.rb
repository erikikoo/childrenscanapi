class SendSmsToApi

    require "http"

    
    
    #$url = "http://sms.kingtelecom.com.br/kingsms/api.php"
    $url = 'https://dashboard.360nrs.com/api/rest/sms'
    #$action = 'sendsms'
    #$login = ''
    #$token = ''
    $urlResponse = 'https://childrenscanapi.herokuapp.com/api/v1/notifica'
    $data = ""
    
    def initialize(numero, msn, emp)
        @numero = numero
        @msn = msn
        @emp = emp
    end

    def sendSmsToApi
        ctx = OpenSSL::SSL::SSLContext.new
        ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
        $data = '{"to":["5511946344764"],"message":"'+@msn+'","from":"'+@emp+'", "notificationUrl":"'+$urlResponse+'"}'
        #$data = '{"to":["5511946344764"],"message":"'+@msn+'","from":"'+@emp+'"}'
        #$data = '{"to":["'+formContactNumber+'"],"message":"'+@msn+'","from":"'+@emp+'"}'
        #puts $data
        #resposte = HTTP.basic_auth(:user => "Haianny", :pass => "08121598").post($url, :ssl_context => ctx, :body => $data)
        #resposte = HTTP.basic_auth(:user => "ErikRdeSouza", :pass => "08121598").post($url, :ssl_context => ctx, :body => $data)
        #puts resposte
        return $data
        
    end

    def formContactNumber
        unless @numero.nil?
            number = @numero.gsub(')', '').gsub('(', '').gsub(' ', '').gsub('-', '') 
            return numberFormat = "55#{number}"
        else
            return @numero
        end    
    end

end    