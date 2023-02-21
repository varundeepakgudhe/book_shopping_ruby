class AddCreditcardPhonenoAddressToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :creditcard, :integer
    add_column :transactions, :phoneno, :integer
    add_column :transactions, :address, :string
  end
end
