class Task < ApplicationRecord
  validates :title, presence: true
  enum status: [ :pending, :inprogress, :completed ]
  scope :filter_by_status, -> (status) { where status: status }
  scope :query_by_title, -> (keyword) { where("title ILIKE ?", "%#{keyword}%")}
end
