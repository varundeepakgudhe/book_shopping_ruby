class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :transactions, dependent: :destroy
  has_many :reviews, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :name, :presence => true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "Invalid email address" }
  validates :username, :presence => true, uniqueness: true
  validates :address, length: {minimum: 1, maximum: 10000}
  validates :credit_card_number, format: { with: /\A\d{4}[- ]?\d{4}[- ]?\d{4}[- ]?\d{4}\z/, message: "Invalid credit card number" }
  validates :phone_number, format: { with: /\A\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\z/, message: "Invalid phone number" }



  private
  def set_default_role
    self.role ||= :user
  end
end
