class Comment < ApplicationRecord
  belongs_to :task
  validates :content, presence: true, length: { maximum: 150 }
end
