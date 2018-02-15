class AddStatusToEmployers < ActiveRecord::Migration[5.1]
  def change
    add_column :employers, :status, :string
  end
end
