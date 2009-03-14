class AdminController < ApplicationController
    require_role "admin", :except => [:about]
    def index
        @events = Event.find(:all, :conditions => ["start > ?", Time.now], :order => "start")
        @locations = Location.find(:all)
        @lists = List.find(:all)
        @boilerplates = BoilerPlate.find(:all)
    end
    
    def about
    end
    
end
