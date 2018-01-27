class AddCommissionsToJobs < ActiveRecord::Migration[5.1]
  def change
  	 add_column :jobs, :commDirect, :text
  	 add_column :jobs, :commResidual, :text
  	 add_column :jobs, :commLead, :text
  end
end
