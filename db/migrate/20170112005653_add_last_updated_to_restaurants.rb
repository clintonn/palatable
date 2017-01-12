class AddLastUpdatedToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :last_updated, :datetime
  end
end
