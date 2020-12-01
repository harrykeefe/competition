class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contests

  validates :name, presence: true
  validates :account_type, presence: true

  FREE_TIER_PRIZE_LIMIT = 3
  PAID_TIER_PRIZE_DEFAULT = 10
  PAID_TIER_PRIZE_LIMIT = 10000

  def prize_limit
    self.account_type == 'free' ? FREE_TIER_PRIZE_LIMIT : PAID_TIER_PRIZE_LIMIT
  end
end
