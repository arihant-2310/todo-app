class Task < ApplicationRecord
  enum status: { not_started: 0, in_progress: 1, blocked: 2, done: 3 }, _default: :not_started
end
