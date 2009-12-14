class AddSequenceToEvent < ActiveRecord::Migration
    def self.up
        add_column :events, :seq, :int, :default => 0
    end
    
    def self.down
        remove_column :events, :seq
    end
end
