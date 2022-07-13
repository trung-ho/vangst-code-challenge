class CreatJobPosting < ActiveRecord::Migration[7.0]
  def change
    create_table :job_postings do |t|
      t.string :name
      t.string :description
      t.integer :number_of_workers
      t.timestamps
    end
  end
end
