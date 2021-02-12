require_relative "athletes"

format_separator = "======================"

laura = Runner.new
laura.name_first = "Laura"
laura.name_last = "Muir"
laura.age = 28
laura.country = "Scotland"
laura.event = "1500m"
laura.pb = 3.55

mo = Runner.new
mo.name_first = "Mohammad"
mo.name_last = "Farah"
mo.age = 38
mo.country = "England"
mo.event = "10000m"
mo.pb = 24.00

dina = Runner.new
dina.name_first = "Dina"
dina.name_last = "Asher Smith"
dina.age = 28
dina.country = "England"
dina.event = "100m"
dina.pb = 10.83

laura.versus(mo)
puts format_separator
dina.versus(laura)
puts format_separator
mo.versus(dina)
puts format_separator
laura.isWanda
puts format_separator

# AG2R La Mondiale
romain = Cyclist.new
romain.name_first = "Romain"
romain.name_last = "Bardet"
romain.team = "AG2R La Mondiale"
romain.rank = 1
romain.career_points = 9181

Tony = Cyclist.new
Tony.name_first = "Tony"
Tony.name_last = "Galllopin"
Tony.team = "AG2R La Mondiale"
Tony.rank = 2
Tony.career_points = 7060

Oliver = Cyclist.new
Oliver.name_first = "Oliver"
Oliver.name_last = "Naesen"
Oliver.team = "AG2R La Mondiale"
Oliver.rank = 3
Oliver.career_points = 4937


Mathias = Cyclist.new
Mathias.name_first = "Oliver"
Mathias.name_last = "Naesen"
Mathias.team = "AG2R La Mondiale"
Mathias.rank = 4
Mathias.career_points = 4239

Frank = Cyclist.new
Frank.name_first = "Frank"
Frank.name_last = "Mathias"
Frank.team = "AG2R La Mondiale"
Frank.rank = 5
Frank.career_points = 4239

# NTT Pro Cycling
Edvald = Cyclist.new
Edvald.name_first = "Edvald"
Edvald.name_last = "Hagen"
Edvald.team = "NTT Pro Cycling"
Edvald.rank = 1
Edvald.career_points = 13844

Roman = Cyclist.new
Roman.name_first = "Roman"
Roman.name_last = "Kreuziger"
Roman.team = "NTT Pro Cycling"
Roman.rank = 2
Roman.career_points = 10218

Domenico = Cyclist.new
Domenico.name_first = "Domenico"
Domenico.name_last = "Pozzovivo"
Domenico.team = "NTT Pro Cycling"
Domenico.rank = 3
Domenico.career_points = 9824

Giacomo = Cyclist.new
Giacomo.name_first = "Giacomo"
Giacomo.name_last = "Nizzolo"
Giacomo.team = "NTT Pro Cycling"
Giacomo.rank = 4
Giacomo.career_points = 6458

Enrico = Cyclist.new
Enrico.name_first = "Enrico"
Enrico.name_last = "Gasparott"
Enrico.team = "NTT Pro Cycling"
Enrico.rank = 5
Enrico.career_points = 5787

# Trek-Segafredo
Vincenzo = Cyclist.new
Vincenzo.name_first = "Vincenzo"
Vincenzo.name_last = "Nibali"
Vincenzo.team = "Trek-Segafredo"
Vincenzo.rank = 1
Vincenzo.career_points = 19153

Bauke = Cyclist.new
Bauke.name_first = "Bauke"
Bauke.name_last = "Mollema"
Bauke.team = "Trek-Segafredo"
Bauke.rank = 2
Bauke.career_points = 11627

Jasper = Cyclist.new
Jasper.name_first = "Jasper"
Jasper.name_last = "Stuyven"
Jasper.team = "Trek-Segafredo"
Jasper.rank = 3
Jasper.career_points = 5736

Mads = Cyclist.new
Mads.name_first = "Mads"
Mads.name_last = "Pedersen"
Mads.team = "Trek-Segafredo"
Mads.rank = 4
Mads.career_points = 4307

Gianluca = Cyclist.new
Gianluca.name_first = "Gianluca"
Gianluca.name_last = "Brambilla"
Gianluca.team = "Trek-Segafredo"
Gianluca.rank = 5
Gianluca.career_points = 3327

puts "\n\n" + format_separator
puts format_separator
Oliver.team
puts format_separator
Edvald.team
puts format_separator
Jasper.team