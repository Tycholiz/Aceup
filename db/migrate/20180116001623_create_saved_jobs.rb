class CreateSavedJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_jobs do |t|
      t.references :seeker, foreign_key: true
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
