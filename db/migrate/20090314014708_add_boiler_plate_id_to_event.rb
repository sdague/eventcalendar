class AddBoilerPlateIdToEvent < ActiveRecord::Migration
    def self.up
        add_column :events, :boiler_plate_id, :int
    end
    
    def self.down
        remove_column :events, :boiler_plate_id
    end
end
