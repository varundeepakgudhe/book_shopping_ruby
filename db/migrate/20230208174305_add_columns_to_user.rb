class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :name, :string, null: false
    add_column :users, :address, :text
    add_column :users, :credit_card_number, :string
    add_column :users, :phone_number, :string
  end
end
