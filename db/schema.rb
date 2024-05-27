# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_526_022_621) do
  create_table 'cart_items', force: :cascade do |t|
    t.integer 'cart_id'
    t.integer 'product_id'
    t.decimal 'subtotal', default: '0.0'
    t.integer 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cart_id'], name: 'index_cart_items_on_cart_id'
    t.index ['product_id'], name: 'index_cart_items_on_product_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.decimal 'total', default: '0.0'
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'nombre'
    t.text 'descripcion'
    t.string 'tipo'
    t.float 'precio', null: false
    t.integer 'stock'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'jti', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['jti'], name: 'index_users_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'cart_items', 'carts'
  add_foreign_key 'cart_items', 'products'
  add_foreign_key 'carts', 'users'
end
