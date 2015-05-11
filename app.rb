require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/sample')
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
