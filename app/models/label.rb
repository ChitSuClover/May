class Label < ApplicationRecord
  belongs_to :task, dependent: :delete
end
