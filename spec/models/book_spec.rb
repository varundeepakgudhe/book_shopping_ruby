# describe Book do
  # tests go here
# end
require 'rails_helper'
require 'spec_helper'
require 'factory_bot_rails'
require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is valid with name, author, publisher, stock, and price" do
    book = Book.new(name: "Book Name", author: "Author Name", publisher: "Publisher Name", stock: 10, price: 9.99)
    expect(book).to be_valid
  end

  it "is not valid without a name" do
    book = Book.new(author: "Author Name", publisher: "Publisher Name", stock: 10, price: 9.99)
    expect(book).not_to be_valid
  end

  it "is not valid without an author" do
    book = Book.new(name: "Book Name", publisher: "Publisher Name", stock: 10, price: 9.99)
    expect(book).not_to be_valid
  end

  it "is not valid without a publisher" do
    book = Book.new(name: "Book Name", author: "Author Name", stock: 10, price: 9.99)
    expect(book).not_to be_valid
  end

  it "is not valid without a stock" do
    book = Book.new(name: "Book Name", author: "Author Name", publisher: "Publisher Name", price: 9.99)
    expect(book).not_to be_valid
  end

  it "is not valid without a price" do
    book = Book.new(name: "Book Name", author: "Author Name", publisher: "Publisher Name", stock: 10)
    expect(book).not_to be_valid
  end
end


