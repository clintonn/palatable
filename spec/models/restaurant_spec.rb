require 'rails_helper'

describe Restaurant, :type => :model do

  before :each do
    @user1 = User.new
    @user2 = User.new
    @review1 = Review.new
    @review2 = Review.new
    @restaurant = Restaurant.new
    @restaurant.reviews << @review1
    @restaurant.reviews << @review2
    @user1.reviews << @review1
    @user2.reviews << @review2

  end


  it "has many reviews" do
    expect(@restaurant.reviews.first).to be_a_kind_of(Review)
    expect(@restaurant.reviews.last).to be_a_kind_of(Review)
  end

  it "knows it owns a review" do
    expect(@review1.restaurant).to be(@restaurant)
    expect(@review2.restaurant).to be(@restaurant)
  end

end
