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

describe('Employee Tracer', { :type => :feature }) do
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

  # it('lets an HR user add employees to a division') do
  #   sales = Division.create(name: "Sales")
  #   bob = Employee.create(name: "Bob")
  #   susan = Employee.create(name: "Susan")
  #   john = Employee.create(name: "John")
  #   visit("/divisions/#{sales.id}")
  #   select bob.id, from: "employees"
  #   select susan.id, from: "employees"
  #   click_button("Add employees")
  #   expect(page).to(have_content("Bob"))
  #   expect(page).to(have_content("Susan"))
  # end

end
