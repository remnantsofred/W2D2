class Room
    attr_accessor :capacity, :occupants
    
    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end
  
    def full?
        return false if @occupants.length < @capacity
        return true if @occupants.length == @capacity
    end

    def available_space
        @capacity - @occupants.length
    end

    def add_occupant(occupant)
        if full?
            return false
        else
            @occupants << occupant
            return true
        end
    end

end