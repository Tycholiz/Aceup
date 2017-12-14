class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstName
      t.string :lastName
      t.string :phoneNo
      t.string :role

      t.timestamps
    end
  end
end
