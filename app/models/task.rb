class Task < ApplicationRecord
  has_many :labels
  validates :title, presence: true
  validates :content, presence: true
  enum status:{
    unstarted: 0,
    in_progress: 1,
    completed: 2
  }
  scope :search, ->(title, status) do
    @title = title
    @status = status
    if @title.present? && @status.present?
      where('title LIKE ?', "%#{@title}%").where(status: @status)
    elsif
      @title.present? && @status.blank?
      where('title LIKE ?', "%#{@title}%")
    elsif
      @status.present? && @title.blank?
      where(status: @status)
    end
  end
end
