module Alias
    def button_state(id: nil, set: nil)
        if id && set
            macro_setstatus(id, set, 1)
        elsif id
            return macro_getstatus(id, 1)            
        end
    end

    def button_stateonly(id: nil, set: nil)
        if id && set
            macro_setstatus(id, set, 2)
        elsif id
            return macro_getstatus(id, 2)            
        end
    end

    def button_trigger(id: nil, set: nil)
        if id && set
            macro_setstatus(id, set, 3)
        elsif id
            return macro_getstatus(id, 3)        
        end
    end
end
