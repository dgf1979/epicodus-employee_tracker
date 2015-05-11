require('spec_helper')

describe(Project) do
  it('tells which project the employee is assigned to') do
    project = Project.create({ :name => 'the Big Presentation'})
    employee = Employee.create({ :name => 'Bob Loblaw', :project_id => project.id() })
    expect(project.employees()).to(eq([employee]))
  end

  describe('#remove') do
    it("removes employees from a project") do
      project = Project.create({ :name => 'the Big Presentation'})
      employee1 = Employee.create({ :name => 'Bob Loblaw', :project_id => project.id() })
      employee2 = Employee.create({ :name => 'Fred', :project_id => project.id() })
      employee3 = Employee.create({ :name => 'Cindy', :project_id => project.id() })
      project.remove([employee2.id, employee3.id])
      expect(project.employees).to(eq([employee1]))
    end
  end
end
