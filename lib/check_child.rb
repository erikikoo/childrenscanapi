class CheckChild

    def self.existChildPerNameAndNasc? name, nasc
        child = Child.find_by(name: name, nascimento: nasc)
        return child if child
            
        return false
    end

    def self.hasChild? name_or_uid, user_id        
        child = Child.find_by(uid: name_or_uid, user_id: user_id)
        child = Child.find_by(name: name, user_id: user_id) unless child
        return child if child
        false
    end
end