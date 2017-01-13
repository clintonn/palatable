class Restaurant < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews

  validates :foursquare_id, uniqueness: true
  validates :name, :address, presence: true

  def set_attributes
    if last_updated.nil? || Time.now - last_updated > 90000
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
    query_url = "https://api.foursquare.com/v2/venues/#{foursquare_id}?v=#{Time.now.strftime("%Y%m%d")}&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}"
    JSON.parse(RestClient.get(query_url))["response"]["venue"]
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
    Review.where(restaurant_id: self.id).order("updated_at DESC").limit(10)
  end

  # testing purposes
  def spaced_address
    address.split('~').join(' ')
  end

  # analytics
  def restaurant_avg_rating
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
