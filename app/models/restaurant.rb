class Restaurant < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews

  def set_attributes
    if last_updated.nil? || Time.now - last_updated > 90000
      response = api_call
      self.url = response["url"] if response["url"]
      if response["contact"]
        self.phone = response["contact"]["formattedPhone"]
        self.twitter = response["contact"]["twitter"]
        self.facebook = response["contact"]["facebook"]
      end
      self.menu = response["menu"]["url"] if response ["menu"]
      photo1 = response["photos"]["groups"].first["items"].first if response["photos"]
      self.photo  ="#{photo1["prefix"]}#{photo1["width"]}x#{photo1["height"]}#{photo1["suffix"]}"
      self.price_tier = response["price"]["tier"] if response["price"]
      self.last_updated = Time.now
    end
  end

  def api_call
    query_url = "https://api.foursquare.com/v2/venues/#{foursquare_id}?v=#{Time.now.strftime("%Y%m%d")}&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}"
    JSON.parse(RestClient.get(query_url))["response"]["venue"]
  end

end
