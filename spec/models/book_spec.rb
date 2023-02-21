# describe Book do
  # tests go here
# end
#
# $LOAD_PATH.unshift('/Users/varundeepakgudhe/.rvm/gems/ruby-3.0.2/gems/factory_bot_rails-6.2.0/lib/factory_bot_rails.rb
# ')

require 'rails_helper'
require 'spec_helper'
# require '/Users/varundeepakgudhe/.rvm/gems/ruby-3.0.2/gems/factory_bot_rails-6.2.0/lib/factory_bot_rails.rb'
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
    subject {FactoryBot.build(:book)}
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
  end

  describe "average rating" do
    it "should calculate correct average rating" do
      subject {FactoryBot.build(:book)}
      user = User.create({name: "fake", email:" fake@gmail.com", username: "fake", password: "long_password1234", password_confirmation:"long_password1234"})
      user.save
      p user.id
      p user.errors
      Review.create({:rating=> 2, :review => "fake", user_id: user.id, book_id: subject.id})
      Review.create({:rating=> 2, :review => "fake", user_id: user.id, book_id: subject.id})
      expect(subject.average_rating).to eq 2
      end
    end

end

