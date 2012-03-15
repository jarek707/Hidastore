class SiteparamsController < ApplicationController
  # GET /siteparams
  # GET /siteparams.json
  def index
    @exposures = Exposure.all
    @elmtypes  = Elmtype.all
    @fields    = Field.all()

    respond_to do |format|
      format.html { render xml: [ "elmtypes" => @elmtypes , "exposures" => @exposures , "fields" => @fields ] }
      format.json { render json: [ "elmtypes" => @elmtypes , "exposures" => @exposures , "fields" => @fields ] }
    end
  end

  def show 
    @exposures = Exposure.all
    @elmtypes  = Elmtype.all
    @fields    = Field.where("plug_id=" + params[:id])

    respond_to do |format|
      format.html { render json: [ "elmtypes" => @elmtypes , "exposures" => @exposures , "fields" => @fields ] }
      format.json { render json: [ "elmtypes" => @elmtypes , "exposures" => @exposures , "fields" => @fields ] }
      format.xml  #{ render xml: [ 'elms' =>@elmtypes , 'fields' => @fields ] }
    end
  end
end
