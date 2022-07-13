class Applicant < ActiveRecord::Base
  belongs_to :job_posting
end