class Keyword < ApplicationRecord
  belongs_to :product, touch: true
end
