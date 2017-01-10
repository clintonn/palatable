class RemoveNeighborhoodFromRestaurants < ActiveRecord::Migration[5.0]
  def change
    remove_column :restaurants, :neighborhood, :string
    add_column :restaurants, :foursquare_id, :string
  end
end
