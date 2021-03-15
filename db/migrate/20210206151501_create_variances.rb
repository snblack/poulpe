class CreateVariances < ActiveRecord::Migration[6.1]
  def change
    create_table :variances do |t|
      t.references :product, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
