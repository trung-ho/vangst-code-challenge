require 'rails_helper'

RSpec.describe Applicant, type: :model do
  before do
    @job_posting = JobPosting.create(
      name: 'Job name',
      description: 'Job description', 
      number_of_workers: 3)
  end

  describe "#validate" do
    it "raise error when name is empty" do
      applicant = @job_posting.applicants.new(email: 'user@example.com')

      applicant.save
      expect(
        applicant.errors.messages[:name].last
      ).to eq "can't be blank"
    end

    it "raise error when email is invalid" do
      applicant = @job_posting.applicants.new(name: 'John doe')

      applicant.save
      expect(
        applicant.errors.messages[:email].last
      ).to eq "is invalid"

      applicant.email = 'JohnDoe@example'
      applicant.save
      expect(
        applicant.errors.messages[:email].last
      ).to eq "is invalid"
    end

    it "raise error when missing job_posting_id" do
      applicant = Applicant.new(name: 'John doe', email: 'user@example.com')

      applicant.save
      expect(
        applicant.errors.messages[:job_posting].last
      ).to eq "must exist"
    end
  end

  describe "#create" do
    it "adding new applicant when all informations are valid" do
      applicant = @job_posting.applicants.new(
        name: 'John doe', email: 'user@example.com')

      expect {
        applicant.save
      }.to change(Applicant, :count).by(1)
    end

    context "when number of applicants exceed number of workers needed" do
      it 'return error' do
        (1..@job_posting.number_of_workers).each do |count|
          @job_posting.applicants.create name: 'John', email: 'user@example.com'
        end

        expect(@job_posting.applicants.count).to eq @job_posting.number_of_workers
        
        exceed_applicant = @job_posting.applicants.create name: 'John', email: 'user@example.com'
        expect(
          exceed_applicant.errors.messages[:job_posting].last
        ).to eq "is full of candidates"
      end
    end
  end
end
