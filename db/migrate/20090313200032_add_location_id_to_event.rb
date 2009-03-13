class AddLocationIdToEvent < ActiveRecord::Migration
    def self.up
        add_column :events, :location_id, :int
        remove_column :events, :location
    end
    
    def self.down
        remove_column :events, :location_id
        add_column :events, :location, :string
    end
end
