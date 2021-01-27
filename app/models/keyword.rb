class Keyword < ApplicationRecord
  has_many :positions, dependent: :delete_all
  belongs_to :product, touch: true
  
  validates :title, presence: true
end
