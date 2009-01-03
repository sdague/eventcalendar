class EventsController < ApplicationController
    # GET /events
    # GET /events.xml
    include EventsHelper
    def index
        @events = Event.find(:all)
        
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
    
  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @event }
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
      @lists = List.find(:all)
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
      @lists = List.find(:all)
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
      @lists = List.find(:all)
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
      @lists = List.find(:all)
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
end
