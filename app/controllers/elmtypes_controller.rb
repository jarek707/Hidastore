class ElmtypesController < ApplicationController
  # GET /elmtypes
  # GET /elmtypes.json
  def index
    @elmtypes = Elmtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @elmtypes }
    end
  end

  # GET /elmtypes/1
  # GET /elmtypes/1.json
  def show
    @elmtype = Elmtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @elmtype }
    end
  end

  # GET /elmtypes/new
  # GET /elmtypes/new.json
  def new
    @elmtype = Elmtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @elmtype }
    end
  end

  # GET /elmtypes/1/edit
  def edit
    @elmtype = Elmtype.find(params[:id])
  end

  # POST /elmtypes
  # POST /elmtypes.json
  def create
    @elmtype = Elmtype.new(params[:elmtype])

    respond_to do |format|
      if @elmtype.save
        format.html { redirect_to @elmtype, notice: 'Elmtype was successfully created.' }
        format.json { render json: @elmtype, status: :created, location: @elmtype }
      else
        format.html { render action: "new" }
        format.json { render json: @elmtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elmtypes/1
  # PUT /elmtypes/1.json
  def update
    @elmtype = Elmtype.find(params[:id])

    respond_to do |format|
      if @elmtype.update_attributes(params[:elmtype])
        format.html { redirect_to @elmtype, notice: 'Elmtype was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @elmtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elmtypes/1
  # DELETE /elmtypes/1.json
  def destroy
    @elmtype = Elmtype.find(params[:id])
    @elmtype.destroy

    respond_to do |format|
      format.html { redirect_to elmtypes_url }
      format.json { head :ok }
    end
  end
end
