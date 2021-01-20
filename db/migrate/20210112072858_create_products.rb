class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :asin, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
