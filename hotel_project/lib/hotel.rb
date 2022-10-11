require_relative "room"

class Hotel
    attr_accessor :rooms

    def initialize(name, room_info)
        @name = name
        @rooms = {}        
        room_info.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity) 
        end
    end

    def name
        names = @name.split(" ")
        capitalized = names.map { |name| name[0].upcase + name[1..-1].downcase }
        capitalized.join(" ")
    end

    def room_exists?(room_name)
        if @rooms.has_key?(room_name)
            return true
        else 
            return false
        end
    end

    def check_in(occupant, room_name)
        if !room_exists?(room_name)
            print 'sorry, room does not exist'
        else
            if @rooms[room_name].add_occupant(occupant)
                print 'check in successful'
            else
                print 'sorry, room is full'
            end
        end
    end

    def has_vacancy?
        @rooms.each_key do | room_name | 
            if !@rooms[room_name].full?
                return true
            end
        end
        false
    end

    def list_rooms
        @rooms.each_key do | room_name |
            print room_name + ".*" + @rooms[room_name].available_space.to_s
            puts
        end
    end   

end
