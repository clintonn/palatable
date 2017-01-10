class SearchController < ApplicationController

  # iteration 1: links are greyed out if the corressponding restaurant does not yet exist in the database

  #

  # iteration 2: display the link to a "dummy show page" that populates the restaurant name and address with the restaurant search result, and then make sure that saves to the database when a person submits a review

  def create
    query_url = "https://api.foursquare.com/v2/venues/search?v=20161016&query=#{params[:search]}&intent=checkin&client_id=#{ENV['foursquare_client_id']}&client_secret=#{ENV['foursquare_client_secret']}&near=#{params[:zipcode]}&limit=10&categoryId=4d4b7105d754a06374d81259"
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

    render :'/search/results'
  end

  def destroy
    #code
  end

end
