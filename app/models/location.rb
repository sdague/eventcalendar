class Location < ActiveRecord::Base
    has_many :events
    validates_presence_of :name
    acts_as_mappable :auto_geocode=>true
    
end
