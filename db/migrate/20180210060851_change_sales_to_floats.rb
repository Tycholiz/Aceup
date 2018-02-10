class ChangeSalesToFloats < ActiveRecord::Migration[5.1]
  def change
  	change_column :jobs, :inSalesSoft, :float
    change_column :jobs, :outSalesSoft, :float
    change_column :jobs, :inSalesHard, :float
    change_column :jobs, :outSalesHard, :float
    change_column :seekers, :outSales, :float
    change_column :seekers, :inSales, :float 
  end
end
