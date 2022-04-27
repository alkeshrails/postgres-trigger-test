class TriggerLoggerJob < ApplicationJob
  queue_as :default

  def perform
    user_changes = UserChange.where(job_status: 'draft')
    user_changes.each do |uc|
      AmountStatusUpdateJob.new(uc.id).perform_now
    end
  end
end
