# GENERAL

This is Trung submission for Vangst code challenge

If you have any questions or concern, please reach me at `trunghdm@gmail.com`

## Schema

This app has 2 tables `job_postings` and `applicants`. `job_posting` has many `applicants` and `applicant` belongs to 1 `job_posting`

`job_postings.name`, `job_postings.description` and `job_postings.number_of_workers` are required

`applicants.name`, `applicants.email` are required, `applicants.cover_letter` is optional

## How to run

### Setup
CD to project

Install rails `7.0.3` in your machine

Run these command line

```
bundle
rake db:create
rake db:migrate
```

### Script
Run the script `rake job_posting:add_applicants` to create job posting and apply to it

It should return something like

```
Apply to job successfull, applicant id is: 15
Apply to job successfull, applicant id is: 16
Apply to job successfull, applicant id is: 17
Apply to job successfull, applicant id is: 18
Apply to job successfull, applicant id is: 19
Now we keep adding more applicant
Cannot add more applicant because of job_posting is full of candidates
```

You can change number of worker at `app/lib/tasks/create_job_posting_and_add_applicants.rake`

### Testcases
Run `rspec` to see all testcases.



