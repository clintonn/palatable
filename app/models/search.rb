class Search < ApplicationRecord
  attr_accessor :query, :results, :query_slug

  def initialize(query, results)
    @query = query
    @results = results
    @query_slug = slugify_query(query)
  end

  def slugify_query(query)
    query[0] = query[0].split(" ").join("+")
    query[1] = query[1].split(" ").join("+")
    "?q=#{query[0]}&location=#{query[1]}"
  end

end
