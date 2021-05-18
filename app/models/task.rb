class Task < ApplicationRecord
  has_many :labels
  validates :title, presence: true
  validates :content, presence: true
  accepts_nested_attributes_for :labels, allow_destroy: true, update_only: true
end
