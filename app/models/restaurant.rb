class Restaurant < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews

  def populate_show
    response = api_call
    self.url = response["url"]
    self.phone = response["contact"]["formattedPhone"]
    self.twitter = response["contact"]["twitter"]
    self.facebook = response["contact"]["facebook"]
    self.menu = response["menu"]["url"] if response ["menu"]
    photo1 = response["photos"]["groups"].first["items"].first
    self.photo ="#{photo1["prefix"]}#{photo1["width"]}x#{photo1["height"]}#{photo1["suffix"]}"
    self.price_tier = response["price"]["tier"]
  end

  def api_call
    query_url = "https://api.foursquare.com/v2/venues/#{foursquare_id}?v=#{Time.now.strftime("%Y%m%d")}&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}"
    JSON.parse(RestClient.get(query_url))["response"]["venue"]
  end

  def spaced_address
    address.split('~').join(' ')
  end

end
