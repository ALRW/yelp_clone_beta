class Review < ActiveRecord::Base
  validates :user, uniqueness: {scope: :restaurant, message: "You have already reviewed this restaurant"}
  belongs_to :user
  belongs_to :restaurant
  has_many :endorsements
  validates :rating, inclusion: (1..5)
end
