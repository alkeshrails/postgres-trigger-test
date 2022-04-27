class AmountStatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(id)
    puts "===============background job run successfull=============="
    UserChange.find(id).update(job_status: "complete");
  end
end