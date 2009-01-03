class AddListIdToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :list_id, :integer
  end

  def self.down
    remove_column :events, :list_id
  end
end
