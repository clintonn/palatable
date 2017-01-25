class Restaurant < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews

  validates :foursquare_id, uniqueness: true
  validates :name, :address, presence: true

  def set_attributes
    # this would be more descriptive if it were a class method that accepted
    # the response from the api
    # you could rename it self.new_from_foursquare_api(response)
    if last_updated.nil? || Time.now - last_updated > 90000 # you should assign this to a local variable to make it clearer to the future programmer what it represents
      response = api_call
      set_contact_info(response) if response["url"]
      set_photos(response)
      self.name = response["name"]
      self.address = response["location"]["formattedAddress"].join("~")
      self.url = response["url"] if response["url"]
      self.menu = response["menu"]["url"] if response ["menu"]
      self.price_tier = response["price"]["tier"] if response["price"]
      self.last_updated = Time.now
    end
  end

  def api_call
    # this should be an adapter that wraps the call to the external api
    # you want to decouple the model logic from the external api as much as
    # possible so that if the api changes, you need only change the adapter
    # what you're doing is building an interface between your application
    # and foursqure's
    query_url = "https://api.foursquare.com/v2/venues/#{foursquare_id}?v=#{Time.now.strftime("%Y%m%d")}&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}"
    JSON.parse(RestClient.get(query_url))["response"]["venue"]
    # would separate the base url, the actual fetching of data, and the
    # parsing into separate methods
  end

  def set_contact_info(response)
    self.phone = response["contact"]["formattedPhone"]
    self.twitter = response["contact"]["twitter"]
    self.facebook = response["contact"]["facebook"]
  end

  def set_photos(response)
    if !response["photos"]["groups"].empty?
      photos = response["photos"]["groups"][0]["items"]
      photo = photos.max_by {|attrs| attrs["width"]}
      self.photo = "#{photo["prefix"]}#{photo["width"]}x#{photo["height"]}#{photo["suffix"]}"
    else
      self.photo = "/default_header.jpg"
    end
  end

  def first_x_reviews(x)
    #? what is x? not sure this is necessary...
    Review.where(restaurant_id: self.id).order("updated_at DESC").limit(10)
  end

  # testing purposes
  def spaced_address
    address.split('~').join(' ')
  end

  # analytics
  def restaurant_avg_rating
    # bet you could do this with an active record query
    # joins(:reviews).average(:avg_rating)
    sum = 0
    self.reviews.each do |review|
      sum += review.avg_rating
    end
      (sum / self.reviews.count.to_f).round(2).to_s
  end

  def self.top_5_rated_restaurants
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.restaurant_avg_rating
    end
    hash.sort_by {|key, value| value }.reverse[0..4]
    # similarly i think there's a query like
    # restaurant_ids = joins(:reviews).group(:id).average(:avg_rating).take(5).pluck(:id)
    # then Restaurant.find(restaurant_ids)
    # something along those lines should work
  end

  def self.lowest_5_rated_restaurants
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.restaurant_avg_rating
    end
    hash.sort_by {|key, value| value }[0..4]
  end

  def avg_food_rating
    sum = 0
    self.reviews.each do |review|
      sum += review.food_rating
    end
      (sum / self.reviews.count.to_f).round(2).to_s
      # same thing all these queries could be done in sql
      # Iterating through all the restaurants works now, but once you have a
      # lot of restaurants, the query will get very expensive and slow down
      # your app
      # so you should reduce the complexity of the operation by cutting down
      # on the iteration
  end

  def self.top_5_food_rated
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.avg_food_rating
    end # returns a hash here
    hash.sort_by {|key, value| value }.reverse[0..4]
  end

  def avg_environment_rating
    sum = 0
    self.reviews.each do |review|
      sum += review.environment_rating
    end
      (sum / self.reviews.count.to_f).round(2).to_s
  end

  def self.top_5_environment_rated
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.avg_environment_rating
    end
    hash.sort_by {|key, value| value }.reverse[0..4]
  end

  def avg_service_rating
    sum = 0
    self.reviews.each do |review|
      sum += review.service_rating
    end
      (sum / self.reviews.count.to_f).round(2).to_s
  end

  def self.top_5_service_rated
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.avg_service_rating
    end
    hash.sort_by {|key, value| value }.reverse[0..4]
  end

  def self.most_reviewed_restaurant
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.reviews.count
    end
    hash.sort_by {|key, value| value }.reverse[0..4]
  end

  def self.food_delta_helper
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.avg_food_rating
    end
    hash
  end

  def self.service_delta_helper
    hash = {}
    Restaurant.all.each do |restaurant|
      hash[restaurant.name] = restaurant.avg_service_rating
    end
    hash
  end

  def self.highest_food_lowest_service
    hash1 = (Restaurant.food_delta_helper) # restaurant.name, food_rating
    hash2 = Restaurant.service_delta_helper # restaurant.name, service_rating
    hash3 = {}
    hash1.keys.each do |res_name|
      hash3[res_name] = hash1[res_name].to_f - hash2[res_name].to_f
    end
    hash3.sort_by {|key, value| value }.reverse[0..4]
  end

end
