class Event < ActiveRecord::Base
    belongs_to :list
    belongs_to :location
    validates_presence_of :name, :description, :location, :list
    alias_attribute :date, :start
    
end
