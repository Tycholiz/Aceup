class ChangeLogoToStringForEmployer < ActiveRecord::Migration[5.1]
  def change
  	change_column :employers, :logo, :string
  end
end