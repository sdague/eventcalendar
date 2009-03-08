# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # AuthenticatedSystem must be included for RoleRequirement, and is provided by installing acts_as_authenticates and running 'script/generate authenticated account user'.
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem


    # this one doesn't work in rails 2.1.2, it should work in rails 2.2.x
    rescue_from ActionController::RoutingError, :with => :route_not_found
    
    rescue_from ActionController::UnknownAction, :with => :invalid_method
    rescue_from ActiveRecord::RecordNotFound, :with => :deny_access

    helper :all # include all helpers, all the time
    
    # See ActionController::RequestForgeryProtection for details
    # Uncomment the :secret if you're not using the cookie session store
    protect_from_forgery # :secret => '8da4e35518f23b9f45747fe51c1c2329'
    
    # See ActionController::Base for details 
    # Uncomment this to filter the contents of submitted sensitive data parameters
    # from your application log (in this case, all fields with names like "password"). 
    # filter_parameter_logging :password
    
    private
    
    def deny_access
        render :text => "No, you can't get that", :status => :method_not_allowed
    end
        
    def route_not_found
        render :text => 'What the f* are you looking for ?', :status => :not_found
    end
    
    def invalid_method
        message = "Now, did your mom tell you to #{request.request_method.to_s.upcase} that ?"
        render :text => message, :status => :method_not_allowed
    end
    
end
