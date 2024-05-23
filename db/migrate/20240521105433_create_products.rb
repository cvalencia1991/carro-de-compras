class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :nombre
      t.text :descripcion
      t.string :tipo
      t.float :precio, null: false
      t.integer :stock
      t.timestamps
    end
  end
end
