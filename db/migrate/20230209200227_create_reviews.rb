class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :review

      t.timestamps
    end
    add_index :reviews, :id, unique: true
  end
end
