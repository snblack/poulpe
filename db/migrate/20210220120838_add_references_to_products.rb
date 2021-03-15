class AddReferencesToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :user, index: true, foreign_key: true
  end
end
