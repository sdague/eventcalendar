class AdminController < ApplicationController
    require_role "admin", :except => [:about]
    def index
    end
    
    def about
    end
    
end
