class Keyword < ApplicationRecord
  has_many :positions, dependent: :delete_all
  belongs_to :product

  validates :title, presence: true

  def current_position
    self.positions.last&.value.to_i
  end

  def changes_thirty_days_ago
    thirty_days_ago =  Date.today - 30
    thirty_days_ago_position = self.positions.find_by(created_at: (thirty_days_ago.beginning_of_day..thirty_days_ago.end_of_day))

    if thirty_days_ago_position == nil
      value = nil
    else
      value = thirty_days_ago_position.value.to_i - current_position
    end
  end
end
