class CreateResumes < ActiveRecord::Migration[5.1]
  def change
    create_table :resumes do |t|
      t.references :seeker, foreign_key: true
      t.string :file
      t.string :title

      t.timestamps
    end
  end
end
