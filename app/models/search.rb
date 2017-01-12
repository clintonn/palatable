class Search < ApplicationRecord
  def set_query_url
    self.query = "?q=#{search.tr("^A-z ", "").split(" ").join("+")}&loc=#{location.split(" ").join("+")}"
  end

end
