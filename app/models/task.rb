class Task < ApplicationRecord
  has_many :labels
  validates :title, presence: true
  validates :content, presence: true
end
