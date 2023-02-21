require 'rails_helper'
require 'spec_helper'
require 'factory_bot_rails'
require 'rails_helper'



RSpec.describe Book, type: :model do
  describe "attributes" do
    it { should respond_to(:name) }
    it { should respond_to(:author) }
    it { should respond_to(:publisher) }
    it { should respond_to(:stock) }
    it { should respond_to(:price) }
  end

  describe "validations" do
    subject {FactoryBot.create(:book)}
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:publisher) }
    it { should validate_presence_of(:stock) }
    it { should validate_presence_of(:price) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(1000) }
    it { should validate_length_of(:author).is_at_least(1).is_at_most(1000) }
    it { should validate_length_of(:publisher).is_at_least(1).is_at_most(1000) }
    it { should validate_numericality_of(:stock).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0.0) }
  end

  describe "associations" do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:transactions).dependent(:destroy) }

    it "should count the associated number of reviews correctly" do
      book = create(:book)
      user = create(:user)
      review1 = create(:review, user: user, book: book, rating: 2)
      review2 = create(:review, user: user, book: book, rating: 2)
      review3 = create(:review, user: user, book: book, rating: 2)
      review4 = create(:review, user: user, book: book, rating: 2)
      expect(book.reviews.count).to eq 4
    end
  end

  describe "average rating" do
    it "should calculate correct average rating" do
      book = create(:book)
      user = create(:user)
      review1 = create(:review, user: user, book: book, rating: 2)
      review2 = create(:review, user: user, book: book, rating: 2)
      expect(book.average_rating).to eq 2
      end
    end

end

