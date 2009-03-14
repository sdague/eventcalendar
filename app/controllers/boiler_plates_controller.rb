class BoilerPlatesController < ApplicationController
    require_role "admin"
  # GET /boiler_plates
  # GET /boiler_plates.xml
  def index
    @boiler_plates = BoilerPlate.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boiler_plates }
    end
  end

  # GET /boiler_plates/1
  # GET /boiler_plates/1.xml
  def show
    @boiler_plate = BoilerPlate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @boiler_plate }
    end
  end

  # GET /boiler_plates/new
  # GET /boiler_plates/new.xml
  def new
    @boiler_plate = BoilerPlate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @boiler_plate }
    end
  end

  # GET /boiler_plates/1/edit
  def edit
    @boiler_plate = BoilerPlate.find(params[:id])
  end

  # POST /boiler_plates
  # POST /boiler_plates.xml
  def create
    @boiler_plate = BoilerPlate.new(params[:boiler_plate])

    respond_to do |format|
      if @boiler_plate.save
        flash[:notice] = 'BoilerPlate was successfully created.'
        format.html { redirect_to(@boiler_plate) }
        format.xml  { render :xml => @boiler_plate, :status => :created, :location => @boiler_plate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @boiler_plate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boiler_plates/1
  # PUT /boiler_plates/1.xml
  def update
    @boiler_plate = BoilerPlate.find(params[:id])

    respond_to do |format|
      if @boiler_plate.update_attributes(params[:boiler_plate])
        flash[:notice] = 'BoilerPlate was successfully updated.'
        format.html { redirect_to(@boiler_plate) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @boiler_plate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boiler_plates/1
  # DELETE /boiler_plates/1.xml
  def destroy
    @boiler_plate = BoilerPlate.find(params[:id])
    @boiler_plate.destroy

    respond_to do |format|
      format.html { redirect_to(boiler_plates_url) }
      format.xml  { head :ok }
    end
  end
end
