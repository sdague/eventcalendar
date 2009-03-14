class CreateBoilerPlates < ActiveRecord::Migration
  def self.up
    create_table :boiler_plates do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :boiler_plates
  end
end
