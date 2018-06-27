class CustomHandleError

    def self.handleError(error)
        case error

            when "Action Not Informed OR Invalid"
                return 101
            when 'Incorrect Login'
                return 102
            when 'Incorrect Token'
                return 103
            when 'Number Not Informed'
                return 104
            when 'Invalid Number'
                return 105
            when 'Incorrect Number Format'
                return 106
            when 'Number Not Movel'
                return 107
            when 'Message Not Informed'
                return 108
            when 'Number of characters > 160'
                return 109
            when 'Without Credit'
                return 110               
            else
                return 422   
                #return error

        end
           
    end    
end

# {"status":"error","cause":"Action Not Informed OR Invalid"}
# {"status":"error","cause":"Incorrect Login"}
# {"status":"error","cause":"Incorrect Token"}
# {"status":"error","cause":"Number Not Informed"}
# {"status":"error","cause":"Invalid Number"}
# {"status":"error","cause":"Incorrect Number Format"}
# {"status":"error","cause":"Number Not Movel"}
# {"status":"error","cause":"Message Not Informed"}
# {"status":"error","cause":"Number of characters > 160"}
# {"status":"error","cause":"Without Credit"}