class AddLastSeenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_seen, :datetime
    add_column :users, :logged_in, :boolean
  end
end
