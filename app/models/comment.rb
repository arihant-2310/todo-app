class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates :content, presence: true, length: { minimum:2, maximum: 150 }
end
