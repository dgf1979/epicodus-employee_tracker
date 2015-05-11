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
  it('logs in as a class of user and saves as a sesion variable') do
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
end
