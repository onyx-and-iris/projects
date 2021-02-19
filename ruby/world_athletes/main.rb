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

runners = [Laura, Mo, Dina, Adam, Amy]

############### CYCLISTS ##################
# AG2R La Mondiale
Romain = Cyclist.ag2r("Romain", "Bardet")
Romain.rank = 1
Romain.career_points = 9181

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

cyclists = [
    Romain, Tony, Oliver, Mathias, Frank,
    Edvald, Roman, Domenico, Giacomo, Enrico,
    Vincenzo, Bauke, Jasper, Mads, Gianluca
]

############### SWIMMERS ##################
# London Roar
AdamP = Swimmer.lonr("Adam", "Peaty")
AdamP.aggregate = 36854
AdamP.pb = "4294"
AdamP.event = "100m Breastroke"

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

swimmers = [
    AdamP, Guilherme, Alia, Sydney, Minna,
    Michael, Marco, Arina, Kasia, Joe,
    Beth, Zach, AmyB, Zane, Lindsey
]

athletes = {
    "runners" => runners, "swimmers" => swimmers, "cyclists" => cyclists
}

def comp_dina(runners)
    """ compare dina asher smith to other runners """
    runners.each do | runner |
        if runner.name_first != "Dina"
            Dina.versus(runner)
        end
    end
end

def comp_swimmers(swimmers)
    """ 
    compare each swimmer vs every other swimmer
    exclude comparisons where distance and stroke are equal
    """
    swimmers.each do | swimmer |
        swimmers.each do | competitor |
            if swimmer.fullname != competitor.fullname
                swimmer.versus(competitor)
            end
        end 
    end
end

def get_cyclist_teams(cyclists)
    """ get team for every cyclist and print bikes used """
    cyclists.each do | cyclist |
        puts "#{cyclist.team}"
    end
end

def comp_cyclists(cyclists)
    """ compare career points between cyclists """
    cyclists.each do | cyclist |
        cyclists.each do | competitor |
            if cyclist.fullname != competitor.fullname
                cyclist.versus(competitor)
            end
        end 
    end
end

def main(athletes)
    comp_dina(athletes["runners"])

    comp_swimmers(athletes["swimmers"])

    get_cyclist_teams(athletes["cyclists"])

    comp_cyclists(athletes["cyclists"])
end


if $PROGRAM_NAME == __FILE__
    main(athletes)
end 
