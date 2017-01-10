class DropTableSearchSessions < ActiveRecord::Migration[5.0]
  def change
    drop_table :search_sessions
    create_table :searches
  end
end
