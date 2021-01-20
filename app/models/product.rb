class Product < ApplicationRecord
  has_many :keywords, dependent: :delete_all
end
