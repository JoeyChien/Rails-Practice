class Task < ApplicationRecord
  validates :title, presence: true
  enum status: [ :pending, :inprogress, :completed ]
end
