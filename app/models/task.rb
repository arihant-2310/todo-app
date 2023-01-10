class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :assignees, through: :assignments, source: :user
  accepts_nested_attributes_for :assignments, allow_destroy: true, reject_if: :all_blank

  enum status: { not_started: 0, in_progress: 1, blocked: 2, done: 3 }, _default: :not_started

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 150 }
  validates :status, inclusion: { in: statuses }
end
