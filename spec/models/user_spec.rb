require 'rails_helper'

describe User, :type => :model do

  before :each do
    @user = User.new
    @review1 = Review.new
    @review2 = Review.new
    @restaurant1 = Restaurant.new
    @restaurant2 = Restaurant.new
    @review1.restaurant = @restaurant1
    @review2.restaurant= @restaurant2
    @user.reviews << @review1
    @user.reviews << @review2

  end


  it "has many reviews" do
    expect(@user.reviews.first).to be_a_kind_of(Review)
    expect(@user.reviews.last).to be_a_kind_of(Review)
  end

  it "knows it owns a review" do
    expect(@user.owns_review?(@review1)).to be(true)
    expect(@user.owns_review?(@review2)).to be(true)
  end

end
