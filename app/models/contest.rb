class Contest < ApplicationRecord
  has_many :prizes, inverse_of: :contest
  belongs_to :user

  accepts_nested_attributes_for :prizes, reject_if: :all_blank?

  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validate :number_of_prizes

  def total_prize_value
    # Opted to use collect over ActiveRecord's sum function to prevent
    # This does require iterating over the array twice which is inideal
    # I think the cost of processing time and memory is lower than repeat
    # SQL Queries

    # A potential better solution would be to create a callback on triggered
    # when the value of prizes change. This callback would save the calculate
    # the total value and store it in the database. Potentially something
    # like https://github.com/magnusvk/counter_culture
    
    # Alternatively could also use russian nesting doll caching on the 
    # view itself breaking the cache and forcing the calculation to occur only
    # after an updated prize value. Here you would have to be careful in how
    # you construct your view as to have it not do the calculation for each 
    # contest.

    prizes.collect(&:value).inject(:+)
  end

  private

  def number_of_prizes
    current_user = User.find self.user_id
    if self.prizes.length > current_user.prize_limit 
      errors.add(:base, "Only #{User::FREE_TIER_PRIZE_LIMIT} allowed on free tier accounts. Please upgrade to the paid tier.")
    end
  end
  
end
