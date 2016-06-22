class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.boolean :admins, default: false
      t.string :password_digest
      t.string :remember_digest
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
