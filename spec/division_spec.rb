require('spec_helper')

describe(Division) do
  it('tells which employees belong to it') do
    division = Division.create({ :name => 'HR'})
    employee = Employee.create({ :name => 'Bob Loblaw', :division_id => division.id() })
    expect(division.employees()).to(eq([employee]))
  end

  it('assigns a division_id to one of its created employees') do
    division = Division.create({ :name => 'HR'})
    employee = division.employees().create({:name => 'Bob Loblaw'})
    expect(employee.division_id()).to(eq(division.id))
  end
end
