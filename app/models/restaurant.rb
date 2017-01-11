class Restaurant < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews


  def get_average
    @restaurant = Restaurant.find_by(foursquare_id: )
    avg =

    (@restaurant.review.service_rating +
    @restaurant.review.food_rating +
    @restaurant.review.environment_rating) / 3
  end




  def sort_avgs
    @restaurants = Restaurant.all

    rest_ratings = [
      {speedy, 4.35}
    ]



    @restaurants.each do |restaurant|
      avg = restaurant.get_average # a number
      rest_ratings << restaurant[:avg]

      if condition

      end
    end

  end

end
