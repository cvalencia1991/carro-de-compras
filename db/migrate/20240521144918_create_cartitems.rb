class CreateCartitems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :subtotal, default: 0.0
      t.integer :quantity
      t.timestamps
    end
  end
end
