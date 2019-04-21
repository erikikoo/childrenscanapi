class CheckChild

    def self.existChildPerNameAndNasc? name, nasc
        child = Child.find_by(name: name, nascimento: nasc)
        return child if child
            
        return false
    end

    def self.hasChild? name, user_id
        # child = Child.find_by(name: name, user_id: user_id)
        child = Child.find_by(name: name)
        return child if child

        false
    end
end