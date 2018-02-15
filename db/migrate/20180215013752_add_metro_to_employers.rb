class AddMetroToEmployers < ActiveRecord::Migration[5.1]
  def change
    add_column :employers, :metro, :string
  end
end
