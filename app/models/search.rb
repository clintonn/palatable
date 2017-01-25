class Search < ApplicationRecord
  def set_query_url
    self.query = "?q=#{search.tr("^A-z ", "").split(" ").join("+")}&loc=#{location.split(" ").join("+")}"
    save
  end

  def api_url
    #again adapter
    #you want to isolate the calls you make to the api
    #in the event that you decide to switch over to another api, you wount
    #all references to a given api in one place
    "https://api.foursquare.com/v2/venues/search?v=20161016&query=#{self.search}&intent=checkin&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}&near=#{self.location}&limit=12&categoryId=4d4b7105d754a06374d81259,4d4b7105d754a06376d81259"
  end

  def map_restaurants(restaurants)
    restaurants.map do |restaurant|
      query = Restaurant.find_by(foursquare_id: restaurant["id"])
      if query.is_a?(Restaurant)
        query.set_attributes
        query.save
        restaurant = query
      else
        restaurant = restaurant
      end
    end
  end
end
