class CreateSearchSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :search_sessions do |t|

      t.timestamps
    end
  end
end
