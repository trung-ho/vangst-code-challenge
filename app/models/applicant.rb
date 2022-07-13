class Applicant < ActiveRecord::Base
  belongs_to :job_posting

  validates :name, presence: true, allow_nil: false
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end