class Position < ApplicationRecord
  belongs_to :keyword, touch: true

  validates :value, presence: true
end
