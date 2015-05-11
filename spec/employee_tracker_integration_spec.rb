require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('Sinatra framework check', { :type => :feature }) do
  it('verifies basic routing and view setup') do
    visit('/test')
    expect(page).to have_content('Sinatra OK')
  end
end

describe('Employee Tracker', { :type => :feature }) do
  it('logs in as a class of user and saves as a session variable') do
    visit('/')
    choose('hr')
    click_button('Continue')
    expect(page).to(have_content('HR'))
  end

end

describe('creating a division', {:type => :feature}) do
  it('allows a user logged in as HR to create a new division') do
    visit('/divisions/add')
    fill_in('name', :with => 'Sales')
    click_button('Add')
    expect(page).to have_content('Sales')
  end
end

describe('user interaction with employees', {:type  => :feature}) do
  it('allows user to create an employee') do
    visit('/employees/add')
    fill_in('name', :with => 'Bob')
    click_button('Add')
    expect(page).to have_content('Bob')
  end

  it('lists all employees') do
    # visit('/employees/add')
    # fill_in('name', :with => 'Bob')
    # click_button('Add')
    Employee.create(name: 'Bob')
    visit('/employees')
    expect(page).to have_content('Bob')
  end

  it('lets an HR user add employees to a division') do
    sales = Division.create(name: "Sales")
    bob = Employee.create(name: "Bob")
    susan = Employee.create(name: "Susan")
    john = Employee.create(name: "John")
    visit("/divisions/#{sales.id}")
    select bob.name, from: "employees[]"
    select susan.name, from: "employees[]"
    click_button("Add")
    expect(html).to_not(have_content('Bob</option>'))
    expect(page).to(have_content("Bob"))
    expect(html).to_not(have_content('Susan</option>'))
    expect(page).to(have_content("Susan"))
  end

  it('lets an HR user add or change the division for an employee') do
    john = Employee.create(name: "John")
    sales = Division.create(name: "Sales")
    visit("/employees/#{john.id()}")
    select(sales.name, from: "divisions")
    click_button('Update Division')
    expect(page).to(have_content("Division: #{sales.name}"))
  end

  it('lets user fire an employee') do
    john = Employee.create(name: "John")
    visit("/employees/#{john.id()}")
    click_button("Fire")
    expect(page).to_not(have_content("John"))
  end

  it('lets user delete a division') do
    sales = Division.create(name: "Sales")
    visit("/divisions/#{sales.id}")
    click_button('Delete')
    expect(page).to_not(have_content('Sales'))
  end
end

describe("user interaction with projects", {:type => :feature}) do
  it("lets a project manager create a project") do
    visit("/projects/add")
    fill_in("name", :with => "Website")
    click_button("Add project")
    expect(page).to(have_content("Website"))
  end

  it("lets a project manager delete a project") do
    project = Project.create(name: 'Doomed to fail')
    visit("/projects/#{project.id()}")
    click_button("Delete")
    expect(page).to_not(have_content('Doomed to fail'))
  end

  it('lets a project manager add employees to a project') do
    money = Project.create(name: "Money")
    bob = Employee.create(name: "Bob")
    susan = Employee.create(name: "Susan")
    john = Employee.create(name: "John")
    visit("/projects/#{money.id}")
    select bob.name, from: "employees[]"
    select susan.name, from: "employees[]"
    click_button("Add")
    expect(html).to_not(have_content('Bob</option>'))
    expect(page).to(have_content("Bob"))
    expect(html).to_not(have_content('Susan</option>'))
    expect(page).to(have_content("Susan"))
  end

  it('un-assigns a user from a project') do
    money = Project.create(name: "Money")
    bob = money.employees.create(name: "Bob")
    visit("/projects/#{money.id}")
    check("#{bob.id}")
    click_button("remove")
# binding.pry
    expect(html).to have_css('option', :text => 'Bob')
    expect(html).to have_css('li', :count => 0)
  end

end
