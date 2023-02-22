class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.references :book, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.decimal :total
      t.decimal :unit_price

      t.timestamps
    end
  end
end
