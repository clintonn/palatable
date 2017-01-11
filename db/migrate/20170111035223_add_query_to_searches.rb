class AddQueryToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :query, :string
    add_column :searches, :search, :string
    add_column :searches, :location, :string
  end
end
