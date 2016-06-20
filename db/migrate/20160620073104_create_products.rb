class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :descriprion
      t.decimal :price
      t.string :image
      t.integer :number
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
