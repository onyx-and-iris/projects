require 'routines'

vmr = Remote.new

OFF = 0
ON = 1

vmr.run do
    num = 0
    (0..2).each do |num|
        vmr.set_parameter("Strip[#{num}].mono", ON)
        puts vmr.get_parameter("Strip[#{num}].mono")
        vmr.set_parameter("Strip[#{num}].mono", OFF)
        puts vmr.get_parameter("Strip[#{num}].mono")
    end

    (0..2).each do |num|
        vmr.set_parameter("Strip[#{num}].gain", 1)
        puts vmr.get_parameter("Strip[#{num}].gain")
        vmr.set_parameter("Strip[#{num}].gain", 0)
        puts vmr.get_parameter("Strip[#{num}].gain")
    end
end
