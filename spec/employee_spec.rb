require('spec_helper')

describe(Employee) do
  it('tells which division the employee belongs to') do
    division = Division.create({ :name => 'HR'})
    employee = Employee.create({ :name => 'Bob Loblaw', :division_id => division.id() })
    expect(employee.division()).to(eq(division))
  end
end
