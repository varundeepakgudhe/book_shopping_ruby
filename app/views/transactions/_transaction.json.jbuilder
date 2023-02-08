json.extract! transaction, :id, :transaction_no, :quantity, :total_price, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
