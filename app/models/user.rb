class User < ApplicationRecord

  has_many :reviews
  has_many :upvotes, through: :reviews
  has_secure_password


  def owns_review?(review)
    review.user == self
  end

  def owns_restaurant_review(restaurant)
    Review.where(["user_id = ? AND restaurant_id = ?", self.id, restaurant.id])
  end

  # analytics
  def self.top_reviewers
    hash = {}
    User.all.each do |reviewer|
      hash[reviewer.name] = reviewer.reviews.count
    end
    hash
  end

end
