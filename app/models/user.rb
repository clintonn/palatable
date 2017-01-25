class User < ApplicationRecord

  has_many :reviews
  has_many :upvotes, through: :reviews
  has_secure_password

  validates :name, :email, presence: true
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 12, too_short: "Password should be at least 12 characters"

  def owns_review?(review)
    # i think this belongs more on the review rather than the user
    # as much as possible you want to reduce the number of methods on user
    # because it can quickly become out of hand as the User class becomes a
    # "God" class
    review.user == self
  end

  def owns_restaurant_review(restaurant)
    Review.where(["user_id = ? AND restaurant_id = ?", self.id, restaurant.id])
  end

  # analytics
  def self.top_reviewers
    #sql this
    hash = {}
    User.all.each do |reviewer|
      hash[reviewer.name] = reviewer.reviews.count
    end
    hash.sort_by {|key, value| value }.reverse[0..4]
  end

end
