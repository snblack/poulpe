class Product < ApplicationRecord
  has_many :keywords, dependent: :delete_all
  has_many :variances, dependent: :delete_all
  has_many :snapshots, dependent: :delete_all

  validates :title, :asin, :image, presence: true
  validates :image, format: URI::regexp(%w[http https])
end
