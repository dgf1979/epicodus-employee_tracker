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
    expect(page).to(have_content('hr'))
  end

end
