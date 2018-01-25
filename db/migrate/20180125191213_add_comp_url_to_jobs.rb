class AddCompUrlToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :CompUrl, :text
  end
end
