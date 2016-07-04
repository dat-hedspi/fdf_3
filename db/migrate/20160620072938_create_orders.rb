class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status, default: "blank"
      t.decimal :total_pay
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
