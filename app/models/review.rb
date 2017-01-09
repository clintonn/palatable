class Review < ApplicationRecord

  has_many :upvotes
  belongs_to :restaurant
  belongs_to :user

end
