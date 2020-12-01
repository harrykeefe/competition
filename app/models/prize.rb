class Prize < ApplicationRecord
  belongs_to :contest

  validates :name, :value, presence: true
  validates :name, length: { maximum: 1000 }
end
