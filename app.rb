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

get('/divisions/:id') do |id|
  @division = Division.find(id.to_i)
  @employees_no_division = Employee.no_division()
  erb(:division)
end

patch('/divisions/:id') do |id|
  employee_ids = params.fetch('employees').map { |id| id = id.to_i }
  employee_ids.each do |employee_id|
    Employee.find(employee_id).update(:division_id => id)
  end
  redirect to("/divisions/#{id}")
end

delete('/divisions/:id') do |id|
  Division.find(id.to_i).destroy
  redirect to('/divisions')
end

#EMPLOYEES
get('/employees') do
  @employees = Employee.all()
  erb(:employees)
end

get('/employees/add') do
  erb(:employee_add_form)
end

post('/employees/add') do
  new_employee = Employee.create(name: params.fetch('name'))
  redirect to("/employees/#{new_employee.id}")
end

patch('/employees/:id') do |id|
  division_id = params.fetch("divisions").to_i
  Employee.find(id.to_i).update(:division_id => division_id)
  redirect to("/employees/#{id}")
end

delete('/employees/:id') do |id|
  Employee.find(id.to_i).destroy()
  redirect to("/employees")
end

get('/employees/:id') do |id|
  @employee = Employee.find(id.to_i)
  @divisions = Division.all
  erb(:employee)
end

#PROJECTS
get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get('/projects/add') do
  erb(:project_add_form)
end

post('/projects/add') do
  Project.create(:name => params.fetch('name'))
  redirect to('/projects')
end

get('/projects/:id') do |id|
  @project = Project.find(id.to_i)
  @employees_no_project = Employee.no_project()
  erb(:project)
end

patch('/projects/:id') do |id|
  employee_ids = params.fetch('employees').map { |id| id = id.to_i }
  employee_ids.each do |employee_id|
    Employee.find(employee_id).update(:project_id => id)
  end
  redirect to("/projects/#{id}")
end

delete('/projects/:id') do |id|
  Project.find(id.to_i).destroy
  redirect to('/projects')
end
