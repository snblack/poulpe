class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.string :value, null: false
      t.references :keyword, index: true, foreign_key: true

      t.timestamps
    end
  end
end
