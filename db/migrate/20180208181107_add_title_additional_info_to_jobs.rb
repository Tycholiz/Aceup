class AddTitleAdditionalInfoToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :title_additionalInfo, :text
  end
end
