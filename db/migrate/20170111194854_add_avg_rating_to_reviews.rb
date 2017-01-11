class AddAvgRatingToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :avg_rating, :numeric
  end
end
