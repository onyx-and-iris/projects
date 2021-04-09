require 'routines'

vmr = Remote.new

OFF = 0
ON = 1

vmr.run do
    """ expect raise boundary error on last set """
    vmr.strip[1].gain(-50.0)
    puts vmr.strip[1].gain

    vmr.strip[1].gain(-60.0)
    puts vmr.strip[1].gain

    vmr.strip[1].gain(12.0)
    puts vmr.strip[1].gain

    vmr.strip[1].gain(-60.1)
    puts vmr.strip[1].gain
end
