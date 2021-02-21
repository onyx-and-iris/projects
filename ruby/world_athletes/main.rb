require_relative "athletes"


Laura = Runner.new("Laura", "Muir", 28,
country: "Scotland", event: "1500m", pb: "3:55")

Mo = Runner.new("Mohammad", "Farah", 38, 
country: "England", event: "10000m", pb: "26:46")

Dina = Runner.new("Dina", "Asher-Smith", 25,
country: "England", event: "100m", pb: "10.83")

Adam = Runner.new("Adam", "Gemili", 27, 
country: "England", event: "100m", pb: "9.97")

Amy = Runner.new("Amy", "Hunt", 18,
country: "England", event: "200m", pb: "22.42")

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

AdamP = Swimmer.lonr("Adam", "Peaty", 
aggregate: 36854, pb: "4294", event: "100m Breastroke")

Guilherme = Swimmer.lonr("Guilherme", "Guido",
aggregate: 33585, pb: "9170", event: "50m Backstroke")

Alia = Swimmer.lonr("Alia", "Atkinson",
aggregate: 32265, pb: "4385", event: "50m Breastroke")

Sydney = Swimmer.lonr("Sydney", "Pickrem",
aggregate: 30364, pb: "4053", event: "200m Medley")

Minna = Swimmer.lonr("Minna", "Atherton",
aggregate: 28910, pb: "10830", event: "100m Backstroke")

# NY Breakers
Michael = Swimmer.nyb("Michael", "Andrew",
aggregate: 31288, pb: "2706", event: "50m Butterfly")

Marco = Swimmer.nyb("Marco", "Koch",
aggregate: 25555, pb: "3033", event: "200m Breaststroke")

Arina = Swimmer.nyb("Arina", "Surkova",
aggregate: 23869, event: "50m Butterfly")

Kasia = Swimmer.nyb("Kasia", "Wasick",
aggregate: 32724)

Joe = Swimmer.nyb("Joe", "Litchfield",
aggregate: 23089, event: "Freestyle")

# DC Trident
Beth = Swimmer.dct("Bethany", "Galat",
aggregate: 22698, pb: "2499", event: "100m Breaststroke")

Zach = Swimmer.dct("Zach", "Apple",
aggregate: 22436, pb: "1583", event: "100m Freestyle")

AmyB = Swimmer.dct("Amy", "Bilquist",
aggregate: 21512, pb: "2710", event: "100m Backstroke")

Zane = Swimmer.dct("Zane", "Grothe",
aggregate: 20718, pb: "3823", event: "400m Freestyle")

Lindsey = Swimmer.dct("Lindsey", "Kozelsky",
aggregate: 20580)

swimmers = [
    AdamP, Guilherme, Alia, Sydney, Minna,
    Michael, Marco, Arina, Kasia, Joe,
    Beth, Zach, AmyB, Zane, Lindsey
]

athletes = {
    :runners => runners, :swimmers => swimmers, :cyclists => cyclists
}

""" Tests """
def comp_dina(athletes)
    """ compare dina asher smith to other runners """
    runners = athletes[:runners]

    runners.each do | runner |
        if runner.object_id != Dina.object_id
            Dina.versus(runner)
        end
    end
end

def comp_swimmers(athletes)
    """ 
    compare each swimmer vs every other swimmer
    exclude comparisons where objects match (athlete vs themself)
    """
    swimmers = athletes[:swimmers]

    swimmers.each do | swimmer |
        swimmers.each do | competitor |
            if swimmer.object_id != competitor.object_id
                swimmer.versus(competitor)
            end
        end 
    end
end

def get_cyclist_teams(athletes)
    """ get team for every cyclist and print bikes used """
    cyclists = athletes[:cyclists]

    cyclists.each do | cyclist |
        print "#{cyclist.team}"
    end
end

def comp_cyclists(athletes)
    """ 
    compare career points between cyclists
    exclude comparisons where objects match (athlete vs themself)
    """
    cyclists = athletes[:cyclists]

    cyclists.each do | cyclist |
        cyclists.each do | competitor |
            if cyclist.object_id != competitor.object_id
                cyclist.versus(competitor)
            end
        end 
    end
end

def main(athletes, args)
    """ build eval string to invoke test run for each arg variable """
    args.each { |func| run = func.to_s; eval(run + "(athletes)") }
end


if $PROGRAM_NAME == __FILE__
    """ pass name(s) of test(s) to run as argument variable(s) """
    args = ARGV

    if args.empty?
        puts 'USAGE: "ruby .\\main.rb <test to run>" eg comp_dina...'
    end

    main(athletes, args)
end 
