class Project < ActiveRecord::Base
  has_many(:employees)

  def remove(employee_ids)
    employee_ids.each { |employee_id| Employee.find(employee_id).update(:project_id => nil) }
  end
end
