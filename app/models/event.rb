class Event < ActiveRecord::Base
    belongs_to :list
    validates_presence_of :name, :description, :location, :list
    
end
