class CheckDevice
    def self.existDevicePerUid? uid        
        device = Device.find_by(uid: uid)
        return device if device
        
        return false 
        
    end
end