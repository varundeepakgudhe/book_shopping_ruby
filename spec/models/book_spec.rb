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

    it { should validate_numericality_of(:stock).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0.0) }
  end

  describe "associations" do
    # add any associations tests here if necessary
  end

  describe "methods" do
    # add any methods tests here if necessary
  end
end

