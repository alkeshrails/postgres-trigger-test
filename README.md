# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

How the application works

* Created postgresql trigger using hair trigger gem.
Whenever amount field is updated on InvoiceItem record, the postgresql trigger
will add a new record in the user_changes table with the information about the change
in amount field with default job_status as draft.

* A seperate cron job is running through sidekiq-scheduler that will run in every 15 seconds. It will check for draft user_chages and run the required background job and update the job_status field.
