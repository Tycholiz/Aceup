class AddTempToSeekers < ActiveRecord::Migration[5.1]
  def change
    add_column :seekers, :temp, :boolean
  end
end
