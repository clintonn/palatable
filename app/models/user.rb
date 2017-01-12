class User < ApplicationRecord

  has_many :reviews
  has_many :upvotes, through: :reviews
  has_secure_password

  #separate concern, do not add
  def owns_review?(review)
    review.user == self
  end

  def owns_restaurant_review(restaurant)
    Review.where(["user_id = ? AND restaurant_id = ?", self.id, restaurant.id])
  end

end
