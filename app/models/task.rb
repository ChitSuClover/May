class Task < ApplicationRecord
  has_many :labels
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  enum status:{
    unstarted: 0,
    in_progress: 1,
    completed: 2
  }
  enum pripority: {
    high: 0,
    medium: 1,
    low: 2
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
