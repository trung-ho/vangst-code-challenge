require 'rails_helper'

RSpec.describe JobPosting, type: :model do
  describe "#validate" do
    it "raise error when name is empty" do
      job_posting = JobPosting.new(description: 'Job description', 
        number_of_workers: 1)
      expect(job_posting.save).to eq false
      expect(job_posting.errors.messages[:name]).to eq ["can't be blank"]
    end

    it "raise error when description is empty" do
      job_posting = JobPosting.new(name: 'Job name', 
        number_of_workers: 1)
      expect(job_posting.save).to eq false
      expect(job_posting.errors.messages[:description]).to eq ["can't be blank"]
    end

    it "raise error when number_of_workers is empty" do
      job_posting = JobPosting.new(name: 'Job name', 
        description: 'Job description')
      expect(job_posting.save).to eq false
      expect(
        job_posting.errors.messages[:number_of_workers].include? "can't be blank"
      ).to eq true
      expect(
        job_posting.errors.messages[:number_of_workers].include? "is not a number"
      ).to eq true
    end

    it "raise error when number_of_workers is invalid" do
      job_posting = JobPosting.new(name: 'Job name', 
        description: 'Job description')

      job_posting.number_of_workers = 'text'
      job_posting.save
      expect(
        job_posting.errors.messages[:number_of_workers].last
      ).to eq "is not a number"


      job_posting.number_of_workers = -1
      job_posting.save
      expect(
        job_posting.errors.messages[:number_of_workers].last
      ).to eq "must be greater than or equal to 1"

      job_posting.number_of_workers = 101
      job_posting.save
      expect(
        job_posting.errors.messages[:number_of_workers].last
      ).to eq "must be less than or equal to 100"
    end

    it "return true when all informations are valid" do
      job_posting = JobPosting.new(name: 'Job name', 
        description: 'Job description',
        number_of_workers: 10)

      expect {
        job_posting.save
      }.to change(JobPosting, :count).by(1)
    end
  end
end
