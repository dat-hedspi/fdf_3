class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :number
      t.references :category, index: true, foreign_key: true
      t.attachment :image

      t.timestamps null: false
    end
    add_index :products, [:category_id, :created_at]
  end
end
