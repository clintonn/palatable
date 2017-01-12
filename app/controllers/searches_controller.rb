class SearchesController < ApplicationController

  def create
    @search = Search.new(search_params)
    @search.set_query_url
    @search.save
    redirect_to search_result_path(@search.query)
  end

  def update
    @search = Search.find(params[:id])
    @search.update(search_params)
    @search.set_query_url
    @search.save
    redirect_to search_result_path(@search.query)
  end

  def show
    @search = Search.find_by(query: params[:query])
    query_url = "https://api.foursquare.com/v2/venues/search?v=20161016&query=#{@search.search}&intent=checkin&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}&near=#{@search.location}&limit=12&categoryId=4d4b7105d754a06374d81259,4d4b7105d754a06376d81259"
    resp = JSON.parse(RestClient.get(query_url))
    @restaurants = resp["response"]["venues"]

    @restaurants.map! do |restaurant|
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

  private

  def search_params
    params.require(:search).permit(:query, :search, :location)
  end

end
