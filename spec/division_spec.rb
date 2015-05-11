require('spec_helper')

describe(Division) do
  it('tells which employees belong to it') do
    division = Division.create({ :name => 'HR'})
    employee = Employee.create({ :name => 'Bob Loblaw', :division_id => division.id() })
# binding.pry
    expect(division.employees()).to(eq([employee]))
  end
end
