class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :jobType
      t.datetime :expiry
      t.string :status
      t.boolean :temp
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
      t.integer :deptSize
      t.text :benefits

      t.timestamps
    end
  end
end
