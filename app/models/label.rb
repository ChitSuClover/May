class Label < ApplicationRecord
  belongs_to :task, dependent: :destroy
end
