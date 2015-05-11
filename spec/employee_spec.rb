require('spec_helper')

describe(Employee) do
  it('tells which division the employee belongs to') do
    division = Division.create({ :name => 'HR'})
    employee = Employee.create({ :name => 'Bob Loblaw', :division_id => division.id() })
    expect(employee.division()).to(eq(division))
  end

  it('tells which project the employee is working on') do
    project = Project.create({:name => 'get more clients'})
    employee = Employee.create({ :name => 'Bob Loblaw', :project_id => project.id() })
    expect(employee.project()).to(eq(project))
  end

  describe('.no_project') do
    it('returns the employees without assigned projects') do
      project = Project.create({:name => 'get more clients'})
      employee1 = Employee.create({ :name => 'Bob Loblaw', :project_id => project.id() })
      employee2 = Employee.create({ :name => 'Bob Loblaw'})
      expect(Employee.no_project).to(eq([employee2]))
    end
  end

end
