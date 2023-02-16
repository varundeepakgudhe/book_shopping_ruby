class ChangeCreditcardToBeStringInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :creditcard, :string
  end
end
