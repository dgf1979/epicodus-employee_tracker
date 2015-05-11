require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/sample')
require('pry')
require('pg')


get('/test') do
  @test_var = 'Sinatra OK'
  erb(:test)
  #redirect to('/')
end
