class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstName
      t.string :lastName
      t.string :phoneNo
      t.string :postalCode
      t.string :educationLevel
      t.string :degree
      t.string :inSales
      t.string :outSales
      t.boolean :inboundSales
      t.boolean :outboundSales

      t.timestamps
    end
  end
end
