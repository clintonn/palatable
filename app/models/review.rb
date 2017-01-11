class Review < ApplicationRecord

  has_many :upvotes
  belongs_to :restaurant
  belongs_to :user

  def calculate_review_avg
    self.avg_rating = ((food_rating + environment_rating + service_rating) / 3.to_f).round(2)
    save
  end

end
