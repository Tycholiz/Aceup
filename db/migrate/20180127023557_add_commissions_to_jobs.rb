class AddCommissionsToJobs < ActiveRecord::Migration[5.1]
  def change
  	 add_column :jobs, :commDirect, :boolean
  	 add_column :jobs, :commResidual, :boolean
  	 add_column :jobs, :commLead, :boolean
  end
end
