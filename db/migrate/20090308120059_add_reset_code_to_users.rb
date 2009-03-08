class AddResetCodeToUsers < ActiveRecord::Migration
    def self.up
        add_column :users, :reset_code, :string
    end
    
    def self.down
    end
end
