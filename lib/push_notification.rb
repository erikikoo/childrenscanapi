class PushNotification
    require 'net/http'

    $APP_ID = ENV["ONESIGNAL_APP_ID"]
    $API_KEY = ENV["ONESIGNAL_API_KEY"]

    $URL = URI.parse('https://onesignal.com/api/v1/notifications')
    
    
    def self.send device_ids, message       
        headers = { "Authorization" => "Basic #{$API_KEY}", "Content-Type" => "application/json" }       
        
        params = {"app_id" => $APP_ID, 
          "contents" => {"en" => message},
          "include_player_ids" => device_ids,
          "priority" => 10        
        }
        
        
        http = Net::HTTP.new($URL.host, $URL.port)
        http.use_ssl = true
        
        request = Net::HTTP::Post.new($URL.path,headers)
        request.body = params.as_json.to_json
        response = http.request(request) 
        return JSON.parse(response.body)
    end

    def self.getNotifications notification_id
        headers = { "Authorization" => "Basic #{$API_KEY}", 
                    "Content-Type" => "application/json"                    
                  }       

        params = {
            "id" => notification_id,
            "app_id" => $APP_ID
        }

        uri = URI.parse("https://onesignal.com/api/v1/notifications/#{notification_id}?app_id=#{$API_KEY}")
        

        http = Net::HTTP.new(uri.host, uri.port)
        # http = Net::HTTP.new($URL.host, $URL.port)
        http.use_ssl = true
        
        request = Net::HTTP::Get.new(uri.path, headers)
        request.body = params.as_json.to_json
        response = http.request(request) 
        return JSON.parse(response.body)
        # return request
    end

    def self.sendNotificationForAllDevices notification, device_ids, image_url = nil, target = nil
         puts "========================================="    
         
         device_ids.each do |device|
             puts device   
         end
         
         puts "========================================="    
        params = {
            "app_id" => $APP_ID,             
            "include_player_ids" => device_ids,
            "priority" => 10           
        }        

        if (target == 'evento') 
          
            $_image_url = image_url if image_url    
            params.merge!("contents" => {"en" => notification.summary})
            params.merge!("big_picture" => $_image_url)
          
            params.merge!("buttons" => [
                    {"id": 'subscribe', 'text': 'Participar', "icon": "#{ActionController::Base.helpers.image_url("like.png")}"}, 
                    {"id": 'unsubscribe', 'text': 'Não Participar', 'icon': "#{ActionController::Base.helpers.image_url("icons/unlike.png")}"}
            ])  

            params.merge!("data" => {"event_id": notification.id})
        
        else 
            # se receber um alerta
            params.merge!("contents" => {"en" => notification.description})
            params.merge!("data" => {"alerta_id": notification.id})
        end

      headers = { "Authorization" => "Basic #{$API_KEY}", "Content-Type" => "application/json" }       
      
      http = Net::HTTP.new($URL.host, $URL.port)
      http.use_ssl = true
      
      request = Net::HTTP::Post.new($URL.path,headers)
      request.body = params.as_json.to_json
      response = http.request(request) 
     
      return JSON.parse(response.body)   
    end
end