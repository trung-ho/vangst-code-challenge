class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :cover_letter
      t.belongs_to :job_posting, index: true
      
      t.timestamps
    end
  end
end
