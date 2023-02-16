class ChangePhonenoToBeStringInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :phoneno, :string
  end
end
