class Task < ApplicationRecord
  enum status: { not_started: 0, in_progress: 1, blocked: 2, done: 3 }, _default: :not_started

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, length: { minimum: 10, maximum: 150 }
  validates :status, inclusion: { in: statuses }
end
