require 'routines'

vmr = Remote.new

OFF = 0
ON = 1

vmr.run do
    (1..3).each do |num|
        vmr.strip[num].mute(ON)
        puts vmr.strip[num].mute
        vmr.strip[num].mute(OFF)
        puts vmr.strip[num].mute
    end

    (1..3).each do |num|
        vmr.strip[num].solo(ON)
        puts vmr.strip[num].solo
        vmr.strip[num].solo(OFF)
        puts vmr.strip[num].solo
    end

    (1..3).each do |num|
        vmr.strip[num].gain(ON)
        puts vmr.strip[num].gain
        vmr.strip[num].gain(OFF)
        puts vmr.strip[num].gain
    end
    
    (1..3).each do |num|
        vmr.strip[num].mono(ON)
        puts vmr.strip[num].mono
        vmr.strip[num].mono(OFF)
        puts vmr.strip[num].mono
    end
=begin
    (1..2).each do |num|
        vmr.bus[num].mute(ON)
        puts vmr.bus[num].mute
        vmr.bus[num].mute(OFF)
        puts vmr.bus[num].mute
    end

    (1..2).each do |num|
        vmr.bus[num].mono(ON)
        puts vmr.bus[num].mono
        vmr.bus[num].mono(OFF)
        puts vmr.bus[num].mono
    end

    (1..2).each do |num|
        vmr.bus[num].gain(ON)
        puts vmr.bus[num].gain
        vmr.bus[num].gain(OFF)
        puts vmr.bus[num].gain
    end
=end
end
