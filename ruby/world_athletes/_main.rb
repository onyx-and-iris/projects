require_relative "athletes"

format_separator = "======================"
############### RUNNERS ##################
Laura = Runner.new("Laura", "Muir", 28)
Laura.country = "Scotland"
Laura.event = "1500m"
Laura.pb = "3:55"

Mo = Runner.new("Mohammad", "Farah", 38)
Mo.country = "England"
Mo.event = "10000m"
Mo.pb = "26:46"

Dina = Runner.new("Dina", "Asher-Smith", 25)
Dina.country = "England"
Dina.event = "100m"
Dina.pb = "10.83"

Adam = Runner.new("Adam", "Gemili", 27)
Adam.country = "England"
Adam.event = "100m"
Adam.pb = "9.97"

Amy = Runner.new("Amy", "Hunt", 18)
Amy.country = "England"
Amy.event = "200m"
Amy.pb = "22.42"

############### CYCLISTS ##################
# AG2R La Mondiale
romain = Cyclist.ag2r("Romain", "Bardet")
romain.rank = 1
romain.career_points = 9181

Tony = Cyclist.ag2r("Tony", "Gallopin")
Tony.rank = 2
Tony.career_points = 7060

Oliver = Cyclist.ag2r("Oliver", "Naesen")
Oliver.rank = 3
Oliver.career_points = 4937

Mathias = Cyclist.ag2r("Frank", "Mathias")
Mathias.rank = 4
Mathias.career_points = 4239

Frank = Cyclist.ag2r("Alexis", "Vuillermoz")
Frank.rank = 5
Frank.career_points = 3003

# NTT Pro Cycling
Edvald = Cyclist.ntt("Edvald", "Hagen")
Edvald.rank = 1
Edvald.career_points = 13844

Roman = Cyclist.ntt("Roman", "Kreuziger")
Roman.rank = 2
Roman.career_points = 10218

Domenico = Cyclist.ntt("Domenico", "Pozzovivo")
Domenico.rank = 3
Domenico.career_points = 9824

Giacomo = Cyclist.ntt("Giacomo", "Nizzolo")
Giacomo.rank = 4
Giacomo.career_points = 6458

Enrico = Cyclist.ntt("Enrico", "Gasparott")
Enrico.rank = 5
Enrico.career_points = 5787

# Trek-Segafredo
Vincenzo = Cyclist.trek("Vincenzo", "Nibali")
Vincenzo.rank = 1
Vincenzo.career_points = 19153

Bauke = Cyclist.trek("Bauke", "Mollema")
Bauke.rank = 2
Bauke.career_points = 11627

Jasper = Cyclist.trek("Jasper", "Stuyven")
Jasper.rank = 3
Jasper.career_points = 5736

Mads = Cyclist.trek("Mads", "Pedersen")
Mads.rank = 4
Mads.career_points = 4307

Gianluca = Cyclist.trek("Gianluca", "Brambilla")
Gianluca.rank = 5
Gianluca.career_points = 3327

############### SWIMMERS ##################
# London Roar
Adam = Swimmer.lonr("Adam", "Peaty")
Adam.aggregate = 36854
Adam.pb = "4294"
Adam.event = "100m Breastroke"

Guilherme = Swimmer.lonr("Guilherme", "Guido")
Guilherme.aggregate = 33585
Guilherme.pb = "9170"
Guilherme.event = "50m Backstroke"

Alia = Swimmer.lonr("Alia", "Atkinson")
Alia.aggregate = 32265
Alia.pb = "4385"
Alia.event = "50m Breastroke"

Sydney = Swimmer.lonr("Sydney", "Pickrem")
Sydney.aggregate = 30364
Sydney.pb = "4053"
Sydney.event = "200m Medley"

Minna = Swimmer.lonr("Minna", "Atherton")
Minna.aggregate = 28910
Minna.pb = "10830"
Minna.event = "100m Backstroke"

# NY Breakers
Michael = Swimmer.nyb("Michael", "Andrew")
Michael.aggregate = 31288
Michael.pb = "2706"
Michael.event = "50m Butterfly"

Marco = Swimmer.nyb("Marco", "Koch")
Marco.aggregate = 25555
Marco.pb = "3033"
Marco.event = "200m Breaststroke"

Arina = Swimmer.nyb("Arina", "Surkova")
Arina.aggregate = 23869
Arina.event = "50m Butterfly"

Kasia = Swimmer.nyb("Kasia", "Wasick")
Kasia.aggregate = 32724

Joe = Swimmer.nyb("Joe", "Litchfield")
Joe.aggregate = 23089
Joe.event = "Freestyle"

# DC Trident
Beth = Swimmer.oct("Bethany", "Galat")
Beth.aggregate = 22698
Beth.pb = "2499"
Beth.event = "100m Breaststroke"

Zach = Swimmer.oct("Zach", "Apple")
Zach.aggregate = 22436
Zach.pb = "1583"
Zach.event = "100m Freestyle"

AmyB = Swimmer.oct("Amy", "Bilquist")
AmyB.aggregate = 21512
AmyB.pb = "2710"
AmyB.event = "100m Backstroke"

Zane = Swimmer.oct("Zane", "Grothe")
Zane.aggregate = 20718
Zane.pb = "3823"
Zane.event = "400m Freestyle"

Lindsey = Swimmer.oct("Lindsey", "Kozelsky")
Lindsey.aggregate = 20580

######################################

Laura.versus(Mo)
puts format_separator
Dina.versus(Laura)
puts format_separator
Mo.versus(Dina)
puts format_separator
Laura.is_wanda
puts format_separator
puts "Lauras pb is: #{Laura.pb}"

puts "\n\n" + format_separator
puts format_separator
Oliver.team
puts format_separator
Edvald.team
puts format_separator
Jasper.team

puts "\n\n" + format_separator
puts format_separator

Alia.versus(Arina)
Zane.versus(Michael)
Kasia.versus(Minna)

