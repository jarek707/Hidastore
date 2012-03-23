class ExposuresController < ApplicationController
  # GET /exposures
  # GET /exposures.json
  def index
    @exposures = Exposure.all
    $jlog.debug @exposures.inspect

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exposures }
    end
  end

  # GET /exposures/1
  # GET /exposures/1.json
  def show
    @exposure = Exposure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exposure }
    end
  end

  # GET /exposures/new
  # GET /exposures/new.json
  def new
    @exposure = Exposure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exposure }
    end
  end

  # GET /exposures/1/edit
  def edit
    @exposure = Exposure.find(params[:id])
  end

  # POST /exposures
  # POST /exposures.json
  def create
    @exposure = Exposure.new(params[:exposure])

    respond_to do |format|
      if @exposure.save
        format.html { redirect_to @exposure, notice: 'Exposure was successfully created.' }
        format.json { render json: @exposure, status: :created, location: @exposure }
      else
        format.html { render action: "new" }
        format.json { render json: @exposure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exposures/1
  # PUT /exposures/1.json
  def update
    @exposure = Exposure.find(params[:id])

    respond_to do |format|
      if @exposure.update_attributes(params[:exposure])
        format.html { redirect_to @exposure, notice: 'Exposure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @exposure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exposures/1
  # DELETE /exposures/1.json
  def destroy
    @exposure = Exposure.find(params[:id])
    @exposure.destroy

    respond_to do |format|
      format.html { redirect_to exposures_url }
      format.json { head :ok }
    end
  end
end
