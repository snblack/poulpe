class CreateSnapshots < ActiveRecord::Migration[6.1]
  def change
    create_table :snapshots do |t|
      t.string :title, null: false
      t.string :image, null: false
      t.string :rating, null: false
      t.string :reviews, null: false

      t.references :product, index: true, foreign_key: true

      t.timestamps
    end
  end
end
