class CreateSeekers < ActiveRecord::Migration[5.1]
  def change
    create_table :seekers do |t|
      t.references :user, foreign_key: true
      t.string :postalCode
      t.integer :educationLevel
      t.text :certifications
      t.string :degree
      t.boolean :driversLicence
      t.boolean :hasVehicle
      t.integer :inSales
      t.integer :outSales
      t.boolean :inboundSales
      t.boolean :outboundSales
      t.boolean :coldCall
      t.boolean :doorToDoor
      t.boolean :custService
      t.boolean :acctManagment
      t.boolean :negotiation
      t.boolean :presenting
      t.boolean :leadership
      t.boolean :closing
      t.boolean :hunterBased
      t.boolean :farmerBased
      t.boolean :commBased
      t.boolean :B2C
      t.boolean :B2B
      t.boolean :consSales
      t.boolean :directSales
      t.boolean :solutionSales
      t.text :languages
      t.timestamps
    end
  end
end