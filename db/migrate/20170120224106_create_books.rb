class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn, limit: 17, null:false
      t.string :title, limit: 100, null:false
      t.decimal :price, precision: 5, scale: 0
      t.string :publish, limit:20, default: '技術評論社'
      t.date :published
      t.boolean :cd

      t.timestamps null: false
    end
  end
end
