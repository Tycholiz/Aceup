class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.references :employer, foreign_key: true
      t.string :title
      t.string :jobType
      t.datetime :expiry
      t.string :status
      t.integer :educationLevel
      t.boolean :temp
      t.boolean :driversLicence
      t.boolean :hasVehicle
      t.string :salary
      t.integer :payLow
      t.integer :payHigh
      t.integer :inSalesSoft
      t.integer :inSalesHard
      t.integer :outSalesSoft
      t.integer :outSalesHard
      t.text :summary
      t.text :functions
      t.text :skills
      t.text :competencies
      t.text :certifications
      t.text :languages
      t.integer :deptSize
      t.text :benefits
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

      t.timestamps
    end
  end
end
