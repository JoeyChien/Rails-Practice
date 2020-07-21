class Task < ApplicationRecord
  validates :title, presence: true
  enum status: [ :pending, :inprogress, :completed ]
  scope :filter_by_status, -> (status) { where(status: Task.statuses[status]) }
  scope :query_by_title, -> (keyword) { where("title ILIKE ?", "%#{keyword}%")}
end
