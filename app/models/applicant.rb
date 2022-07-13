class Applicant < ActiveRecord::Base
  belongs_to :job_posting

  validates :name, presence: true, allow_nil: false
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validate :check_number_of_candidates, on: :create

  private

  def check_number_of_candidates
    if job_posting
      job_posting.with_lock do
        errors.add(:job_posting, 'is full of candidates') if job_posting.applicants.count == job_posting.number_of_workers
      end
    end
  end
end