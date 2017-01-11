class Search < ApplicationRecord
  def set_query_url
    self.query = "?q=#{search.split(" ").join("+")}&loc=#{location.split(" ").join("+")}"
  end

end
