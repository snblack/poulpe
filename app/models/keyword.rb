class Keyword < ApplicationRecord
  belongs_to :product, touch: true
  validates :title, presence: true
end
