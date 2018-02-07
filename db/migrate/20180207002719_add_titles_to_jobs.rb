class AddTitlesToJobs < ActiveRecord::Migration[5.1]
  def change
  	add_column :jobs, :title_functions, :text
  	add_column :jobs, :title_skills, :text
  	add_column :jobs, :title_comp, :text
  	add_column :jobs, :title_benefits, :text
  end
end
