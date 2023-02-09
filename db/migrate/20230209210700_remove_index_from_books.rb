class RemoveIndexFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_index :books, :id
  end
end
