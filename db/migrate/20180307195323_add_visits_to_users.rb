class AddVisitsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :visits, :integer
  end
end
