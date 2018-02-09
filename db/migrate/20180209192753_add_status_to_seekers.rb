class AddStatusToSeekers < ActiveRecord::Migration[5.1]
  def change
    add_column :seekers, :status, :string
  end
end
