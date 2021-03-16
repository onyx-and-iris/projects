require 'sinatra'
require 'athletes'

get('/runners') do
    @Laura = Runner.new("Laura", "Muir", 28,
    country: "Scotland", event: "1500m", pb: "3:55")
    @Mo = Runner.new("Mohammad", "Farah", 38, 
    country: "England", event: "10000m", pb: "26:46")
    @Dina = Runner.new("Dina", "Asher-Smith", 25,
    country: "England", event: "100m", pb: "10.83")
    @Adam = Runner.new("Adam", "Gemili", 27, 
    country: "England", event: "100m", pb: "9.97")
    @Amy = Runner.new("Amy", "Hunt", 18,
    country: "England", event: "200m", pb: "22.42")
    @runners = [@Laura, @Mo, @Dina, @Adam, @Amy]

    erb :index
end

get('/runners/new') do
    erb :new
end

