class Contest < ApplicationRecord
  has_many :prizes, inverse_of: :contest
  belongs_to :user

  accepts_nested_attributes_for :prizes, reject_if: :all_blank?

  def total_prize_value
    prizes.sum(:value)
  end
end
