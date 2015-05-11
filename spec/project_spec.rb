require('spec_helper')

describe(Project) do
  it('tells which project the employee is assigned to') do
    project = Project.create({ :name => 'the Big Presentation'})
    employee = Employee.create({ :name => 'Bob Loblaw', :project_id => project.id() })
    expect(project.employees()).to(eq([employee]))
  end
end
