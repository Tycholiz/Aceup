class AddMetroToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :metro, :string
  end
end
