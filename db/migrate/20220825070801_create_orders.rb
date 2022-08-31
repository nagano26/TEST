class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :order_number
      t.integer :order_sumprice
      t.datetime :order_datetime

      t.timestamps
    end
  end
end
