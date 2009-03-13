class EventsController < ApplicationController
    require_role "admin", :except => [:index, :show, :embed]
    before_filter :find_supporting,  :only => [:new, :create, :copy, :edit, :update] 

    # GET /events
    # GET /events.xml
    include EventsHelper
    def index
        @events = Event.find(:all)
        if params[:date]
            @date = Date.parse(params[:date])
        else
            @date = Date.today
        end
        
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @events }
            format.json { 
                render :json => @events 
            }
            format.ics {
                response.content_type = "text/calendar"
                cal = event_calendar(@events, "America/New_York")
                cal.ip_method = "PUBLISH"
                render :text => cal.to_ical
            }
            format.text {
                response.content_type = "text/plain"
                cal = event_calendar(@events, "America/New_York")
                cal.ip_method = "PUBLISH"
                render :text => cal.to_ical
            }
        end
    end

    def embed
        @events = Event.find(:all)
        if params[:date]
            @date = Date.parse(params[:date])
        else
            @date = Date.today
        end
        respond_to do |format|
            format.html {
                render :layout => "slim"
            } # index.html.erb
        end
    end
    
    # GET /events/1
    # GET /events/1.xml
    def show
        @event = Event.find(params[:id])
        @map = create_map(@event.location)
        
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @event }
            format.json { 
                render :json => @event
            }
            format.ics {
                response.content_type = "text/calendar"
                cal = event_calendar([@event], "America/New_York")
                cal.ip_method = "PUBLISH"
                render :text => cal.to_ical
            }
            format.text {
                response.content_type = "text/plain"
                render :text => Notifier.create_invitation(@event)
            }
        end
    end
    
    def email
        @event = Event.find(params[:id])
        Notifier.deliver_invitation(@event)
        respond_to do |format|
            flash[:notice] = "Email sent out for #{@event.name}."
            format.html { redirect_to(events_url) }
            format.xml  { head :ok }
        end
    end

    # GET /events/new
    # GET /events/new.xml
    def new
        @event = Event.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @event }
        end
    end

    # GET /events/1/edit
    def edit
        @event = Event.find(params[:id])
    end

    # GET /events/1/copy
    def copy
        old_event = Event.find(params[:id])
        @event = Event.new
        @event.update_attributes(old_event.attributes)
        
        respond_to do |format|
            format.html { render :action => "edit" }
            format.xml  { head :ok }
        end
    end
    
    # POST /events
    # POST /events.xml
    def create
        @event = Event.new(params[:event])

        respond_to do |format|
            if @event.save
                flash[:notice] = 'Event was successfully created.'
                format.html { redirect_to(@event) }
                format.xml  { render :xml => @event, :status => :created, :location => @event }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /events/1
    # PUT /events/1.xml
    def update
        @event = Event.find(params[:id])

        respond_to do |format|
            if @event.update_attributes(params[:event])
                flash[:notice] = 'Event was successfully updated.'
                format.html { redirect_to(@event) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
            end
        end
    end

    # DELETE /events/1
    # DELETE /events/1.xml
    def destroy
        @event = Event.find(params[:id])
        @event.destroy

        respond_to do |format|
            format.html { redirect_to(events_url) }
            format.xml  { head :ok }
        end
    end
    
    private
    def find_supporting
        @lists = List.find(:all)
        @locations = Location.find(:all)
    end
    
    def create_map(location)
        map = GoogleMap.new(:type => "G_HYBRID_MAP")
        map.markers << GoogleMapMarker.new(
                                           :map => map,
                                           :lat => location.lat,
                                           :lng => location.lng,
                                           :html => location.name
                                           )
        return map
    end
end
