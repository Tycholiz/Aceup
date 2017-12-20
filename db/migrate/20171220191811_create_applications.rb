class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.references :seeker, foreign_key: true
      t.references :job, foreign_key: true
      t.string :resume
      t.timestamps
    end
  end
end
