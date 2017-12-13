class ChangeColumnName2 < ActiveRecord::Migration[5.1]
  def change
  	rename_column :jobs, :type, :jobType
  end
end
