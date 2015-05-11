ENV['RACK_ENV'] = 'test'

require('sinatra/activerecord')
require('rspec')
require('pg')
require('pry')
require('./lib/division')
require('./lib/employee')


RSpec.configure do |config|
  config.before(:each) do
    #optionally do something before each test
  end
  config.after(:each) do
    #optionally do something after each test
    Division.all().each() do |division|
      division.destroy()
    end
    Employee.all().each() do |employee|
      employee.destroy()
    end
  end
end
