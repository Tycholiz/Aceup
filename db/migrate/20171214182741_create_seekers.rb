class CreateSeekers < ActiveRecord::Migration[5.1]
  def change
    create_table :seekers do |t|
      t.belongs_to :user, index: true
      t.string :postalCode
      t.string :educationLevel
      t.string :degree
      t.integer :inSales
      t.integer :outSales
      t.boolean :inboundSales
      t.boolean :outboundSales

      t.timestamps
    end
  end
end
