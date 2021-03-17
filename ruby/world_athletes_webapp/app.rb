require 'sinatra'
require 'athletes'
require 'yaml_store'

store = AthleteStore.new('athletes.yml')

get('/runners') do
    @runners = store.show
    erb :index
end

get('/runners/new') do
    erb :new
end

post('/runners/create') do
    @runner = Runner.new(
    params['name_first'],
    params['name_last'],
    params['age'].to_i,
    country: params['country'],
    event: params['event'],
    pb: params['pb']
    )
    store.save(@runner)
    redirect 'runners/new'
end

get('/runners/:id') do
    id = params['id'].to_i
    @runner = store.find(id)
    erb :show
end

