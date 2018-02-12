class ChangeDeptSizeToStringOnJobs < ActiveRecord::Migration[5.1]
  def change
  	change_column :jobs, :deptSize, :string
  end
end
