class Position < ApplicationRecord
  belongs_to :keyword

  scope :today, -> { where(:created_at => (Time.now.beginning_of_day..Time.now.end_of_day)) }

  validates :value, presence: true
  # validate :validate_time_limit, :on => :create

  private

  def validate_time_limit
    unless self.keyword.positions.today.count.zero?
      errors.add(:base, "Exceeds daily limit")
    end
  end

end
