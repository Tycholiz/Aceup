class AddAdditionalInfoToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :additionalInfo, :text
  end
end
