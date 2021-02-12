require_relative "athletes"

format = "======================"

laura = Runner.new
laura.name = "laura muir"
laura.age = 28
laura.country = "Scotland"
laura.event = "1500m"
laura.pb = 3.55

mo = Runner.new
mo.name = "mo farah"
mo.age = 38
mo.country = "England"
mo.event = "10000m"
mo.pb = 24.00

dina = Runner.new
dina.name = "dina asher smith"
dina.age = 28
dina.country = "England"
dina.event = "100m"
dina.pb = 10.83

laura.versus(mo)
puts format
dina.versus(laura)
puts format
mo.versus(dina)