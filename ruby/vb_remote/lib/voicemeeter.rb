require_relative 'routines'

class Remote < Routines
    """
    subclass to BaseRoutines.
    Performs log in/out routines cleanly.
    May yield a block argument otherwise simply login.
    """
    def initialize(type = nil, **opts)
        logmein = opts.delete(:logmein)
        super(type, **opts)
        self.run if logmein
    end

    def run
        login

        if block_given?
            yield
            
            logout
        end
    end
end
