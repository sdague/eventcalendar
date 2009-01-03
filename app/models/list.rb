class List < ActiveRecord::Base
    has_many :events
    validates_presence_of :name
    # these need to be emails
    validates_format_of :address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i
    validates_format_of :from, :with => /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\Z/i
end
