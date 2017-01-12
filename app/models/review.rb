class Review < ApplicationRecord

  has_many :upvotes
  belongs_to :restaurant
  belongs_to :user

  def restaurant_name
    @testing = Restaurant.find(self.restaurant_id)
    @testing.name
  end

  def calculate_review_avg
    self.avg_rating = ((food_rating + environment_rating + service_rating) / 3.to_f).round(2)
    save
  end

  def ratings_hash
    {"Food" => food_rating, "Environment" => environment_rating, "Service" => service_rating}
  end

end
