class SearchController < ApplicationController

  def create
    query_url = "https://api.foursquare.com/v2/venues/search?v=20161016&query=#{params[:search]}&intent=checkin&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}&near=#{params[:location]}&limit=10&categoryId=4d4b7105d754a06374d81259"

    resp = JSON.parse(RestClient.get(query_url))
    @restaurants = resp["response"]["venues"]

    @restaurants.map! do |restaurant|
      query = Restaurant.find_by(foursquare_id: restaurant["id"])
      if query.is_a?(Restaurant)
        restaurant = query
      else
        restaurant = restaurant
      end
    end
    # render :results
    # New implementation below: Add search instance instead, redirect to show page for url query handling
    @search = Search.new([params[:search], params[:location]], @restaurants)
    redirect_to @search
  end

  def destroy
    #code
  end

  private

  def search_params
    params.require(:search).permit(:query, :results)
  end

end
