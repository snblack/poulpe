class CreateKeywords < ActiveRecord::Migration[6.1]
  def change
    create_table :keywords do |t|
      t.string :title
      t.references :product, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
