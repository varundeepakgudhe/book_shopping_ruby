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
  validates :address,:allow_blank => true,  length: {minimum: 1, maximum: 10000}
  validates :credit_card_number,:allow_blank => true, format: { with: /\A\d{16}\z/, message: "Invalid credit card number [ must be 16 digits ]" }
  validates :phone_number, :allow_blank => true, format: { with: /\A[0-9]{10}\Z/, message: "Invalid phone number [ must be 10 digits ]" }



  private
  def set_default_role
    self.role ||= :user
  end
end
