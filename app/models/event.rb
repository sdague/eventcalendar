class Event < ActiveRecord::Base
    belongs_to :list
    belongs_to :location
    belongs_to :boiler_plate
    validates_presence_of :name, :description, :location, :list
    alias_attribute :date, :start
    
end
