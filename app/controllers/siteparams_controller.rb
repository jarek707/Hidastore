class SiteparamsController < ApplicationController

  # GET /siteparams
  # GET /siteparams.json
  def index
    @exposures = Exposure.order('flag ASC')
    @elmtypes  = Elmtype.all

    respond_to do |format|
      format.html { render xml: [ "elmtype_id" => @elmtypes , "exposure_id" => @exposures ] }
    end
  end

  def selects 
    @exposures = Exposure.order('flag ASC')
    @elmtypes  = Elmtype.all

    respond_to do |format|
      format.json { render json: { "elmtype_id" => @elmtypes , "exposure_id" => @exposures } }
    end
  end

  def fields 
    #@fields    = Field.where("plug_id=" + params[:id])
    @fields    = Field.all
    logger.debug ( " .................. params/fields  called" )

    respond_to do |format|
      format.html { render json: [ "fields" => @fields ] }
      format.json { render json: [ "fields" => @fields ] }
      format.xml  #{ render xml: [ 'fields' => @fields ] }
    end
  end

  def show 
    @fields    = Field.where("plug_id=" + params[:id])

    respond_to do |format|
      format.html { render json: [ "fields" => @fields ] }
      format.json { render json: [ "fields" => @fields ] }
      format.xml  #{ render xml: [ 'fields' => @fields ] }
    end
  end
end
