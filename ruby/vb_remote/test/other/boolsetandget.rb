require 'routines'

vmr = Remote.new

OFF = 0
ON = 1

vmr.run do
    (1..3).each do |num|
        vmr.strip[num].mute = true
        puts vmr.strip[num].mute
        vmr.strip[num].mute = false
        puts vmr.strip[num].mute
    end
end
