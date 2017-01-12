class Review < ApplicationRecord

  has_many :upvotes
  belongs_to :restaurant
  belongs_to :user
  validates :title, :content, :food_rating, :environment_rating, :service_rating, :restaurant_id, :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:restaurant_id]

  def restaurant_name
    Restaurant.find(self.restaurant_id).name
  end

  def calculate_review_avg
    self.avg_rating = ((food_rating + environment_rating + service_rating) / 3.to_f).round(2)
    save
    avg_rating
  end

  def ratings_hash
    {"Food" => food_rating, "Environment" => environment_rating, "Service" => service_rating}
  end
end
