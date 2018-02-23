class AddIndustryRelatedToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :industry_related, :string
  end
end
