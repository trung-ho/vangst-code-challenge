class JobPosting < ActiveRecord::Base
  has_many :applicants

  validates :name, presence: true, allow_nil: false
  validates :description, presence: true, allow_nil: false

  validates( :number_of_workers, presence: true, allow_nil: false,
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 100
    }
  )
end