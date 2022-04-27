class UserChange < ApplicationRecord
  enum job_status: { draft: 0, complete: 1 }
end
