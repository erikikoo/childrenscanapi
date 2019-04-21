class CheckDevice
    def self.existDevicePerUid? uid        
        device = Device.find_by(uid_onesignal: uid)
        return device if device
        
        return false 
        
    end
end