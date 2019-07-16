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
          "priority" => 10,
        #  "data" => {"notification_id": notification_id}             
        # "include_player_ids" => ['122']
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

    def self.sendNotificationForAllDevices evento, id, image_url = nil
        $_image_url = image_url if image_url
        params = {"app_id" => $APP_ID, 
            "contents" => {"en" => evento.title},
            "included_segments" => ["Active Users", "Inactive Users"],
            "big_picture" => $_image_url,
            "priority" => 10,
            "buttons" => [
                {"id": 'subscribe', 'text': 'Participar', "icon": "#{ActionController::Base.helpers.image_url("like.png")}"}, 
                {"id": 'unsubscribe', 'text': 'Não Participar', 'icon': "#{ActionController::Base.helpers.image_url("icons/unlike.png")}"}
            ],
            "data" => {"event_id": id}            
        }
      
      headers = { "Authorization" => "Basic #{$API_KEY}", "Content-Type" => "application/json" }       
      
      http = Net::HTTP.new($URL.host, $URL.port)
      http.use_ssl = true
      
      request = Net::HTTP::Post.new($URL.path,headers)
      request.body = params.as_json.to_json
      response = http.request(request) 
     
      return JSON.parse(response.body)   
    end
end