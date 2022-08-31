class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_name_kana
      t.integer :product_zaiko
      t.integer :product_price
      t.string :product_stopflag

      t.timestamps
    end
  end
end
