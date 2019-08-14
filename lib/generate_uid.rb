class GenerateUid
    require 'securerandom'
    
    def self.generate
        return SecureRandom.uuid
    end

    def self.generate_code
        _number = []
        6.times do
            _number << rand(0..9)
        end
        return _number.join
    end


end