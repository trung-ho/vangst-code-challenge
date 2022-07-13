namespace :job_posting do
  desc "Create job posting and add worker, if it exceed number of worker needed then return error"
  task add_applicants: :environment do
    job_posting = JobPosting.create!(
      name: 'Job name',
      description: 'Job description', 
      number_of_workers: 5)

    puts "Create Job posting successfull, job_posting id is: " + job_posting.id.to_s
    
    (1..job_posting.number_of_workers).each do |count|
      applicant = job_posting.applicants.create! name: 'John', email: 'user@example.com'
      puts "Apply to job successfull, applicant id is: " + applicant.id.to_s
    end

    puts "Now we keep adding more applicant"

    applicant = job_posting.applicants.create name: 'John', email: 'user@example.com'

    applicant.save

    if applicant.errors.any?
      message = applicant.errors.messages[:job_posting].last
      puts "Cannot add more applicant because of job_posting " + message
    end
  end
end
