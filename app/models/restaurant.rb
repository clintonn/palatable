class Restaurant < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews

  def set_attributes
    # TO-DO: REFACTOR
    if last_updated.nil? || Time.now - last_updated > 90000
      response = api_call
      set_contact_info(response) if response["url"]
      set_photos(response)

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
      photo1 = response["photos"]["groups"].first["items"].first
      self.photo = "#{photo1["prefix"]}#{photo1["width"]}x#{photo1["height"]}#{photo1["suffix"]}"
    else
      self.photo = "/default_header.jpg"
    end
  end

end
