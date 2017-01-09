class User < ApplicationRecord

  has_many :reviews
  has_many :upvotes, through: :reviews
  has_secure_password

end
