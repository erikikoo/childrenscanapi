class GenerateUid
    require 'securerandom'
    
    def self.generate
        return SecureRandom.uuid
    end

end