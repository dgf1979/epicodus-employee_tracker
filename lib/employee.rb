class Employee < ActiveRecord::Base
  belongs_to(:division)
  belongs_to(:project)

  scope(:no_project, -> do
        Employee.where(:project_id => nil)
      end)
end
