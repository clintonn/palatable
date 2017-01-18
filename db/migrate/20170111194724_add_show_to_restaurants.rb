class AddShowToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :url, :string
    add_column :restaurants, :phone, :string
    add_column :restaurants, :twitter, :string
    add_column :restaurants, :facebook, :string
    add_column :restaurants, :menu, :string
    add_column :restaurants, :photo, :string
    add_column :restaurants, :price_tier, :integer
    add_column :restaurants, :last_updated, :datetime
  end
end
