class CreateEmployers < ActiveRecord::Migration[5.1]
  def change
    create_table :employers do |t|
      t.references :user, foreign_key: true
      t.string :compName
      t.integer :compSize
      t.string :city
      t.binary :logo
      t.string :compDesc

      t.timestamps
    end
  end
end
