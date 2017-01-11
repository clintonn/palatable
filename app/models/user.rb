class User < ApplicationRecord

  has_many :reviews
  has_many :upvotes, through: :reviews
  has_secure_password

  #separate concern, do not add
  def owns_review?(review)
    review.user == self
  end

end
