class Snapshot < ApplicationRecord
  belongs_to :product

  def changed?(product)
    last_snapshot = product.snapshots.last

    if self.title != last_snapshot&.title
      return true
    elsif self.image != last_snapshot&.image
      return true
    elsif self.rating != last_snapshot&.rating
      return true
    elsif self.reviews != last_snapshot&.reviews
      return true
    end
  end

end
