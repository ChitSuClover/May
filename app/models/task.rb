class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label
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
  scope :search, ->(title, status, label) do
    @title = title
    @status = status
    @label = label
    if @title.present? && @status.present? && @label.present?
      where('title LIKE ?', "%#{@title}%").where(status: @status).where(label_id: @label)
    elsif
      @title.present? && @status.blank? && @label.blank?
      where('title LIKE ?', "%#{@title}%")
    elsif
      @status.present? && @title.blank? && @label.blank?
      where(status: @status)
    elsif
      @label.present? && @title.blank? && @status.blank?
      joins(:labels).where(labels: { id: @label })
    end
  end
end
