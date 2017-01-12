require 'rails_helper'

describe Review, :type => :model do

  before :each do
    @user = User.new
    @restaurant = Restaurant.new
    @review = Review.new
    @review.user = @user
    @review.restaurant = @restaurant
  end

  it "is valid with valid attributes" do
    expect(@review).to be_valid
  end

  it "belongs to a user" do
    expect(@review.user).to be_a_kind_of(User)
  end

  it "belongs to a restaurant" do
    expect(@review.restaurant).to be_a_kind_of(Restaurant)
  end

  it "properly calculates its average" do
    @review.food_rating = 4
    @review.environment_rating = 4
    @review.service_rating = 5
    @review.calculate_review_avg
    expect(@review.avg_rating).to eq(4.33)
  end

end
