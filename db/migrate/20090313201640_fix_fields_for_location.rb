class FixFieldsForLocation < ActiveRecord::Migration
    def self.up
        change_column :locations, :description, :text
        change_column :locations, :address, :text
    end
    
    def self.down
        change_column :locations, :description, :string
        change_column :locations, :address, :string
    end
end
