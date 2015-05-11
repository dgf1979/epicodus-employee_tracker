require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/division')
require('./lib/employee')
require('./lib/project')
require('pry')
require('pg')

enable :sessions

get('/test') do
  @test_var = 'Sinatra OK'
  erb(:test)
  #redirect to('/')
end

get('/') do
  erb(:index)
end

post('/') do
  session[:user_type] = params.fetch('user_type')
  redirect to('/')
end

#DIVISIONS
get('/divisions/add') do
  erb(:division_add_form)
end

post('/divisions/add') do
  new_division = Division.create(name: params.fetch('name'))
  redirect to('/divisions')
end

get('/divisions') do
  @divisions = Division.all()
  erb(:divisions)
end
