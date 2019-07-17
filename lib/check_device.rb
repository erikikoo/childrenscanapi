class CheckDevice
    def self.existDevicePerUid? uid        
        device = Device.find_by(uid_onesignal: uid)
        return device if device
        
        return false 
        
    end

    def self.getAllDevices children
        devices_id = []  
        devices = child.devices
        
        devices.each do |d|
          devices_id << d.uid_onesignal         
        end
    end
end