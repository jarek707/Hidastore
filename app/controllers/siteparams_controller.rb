class SiteparamsController < ApplicationController
  # GET /siteparams
  # GET /siteparams.json
  def show 
    @exposures = Exposure.all
    @elmtypes  = Elmtype.all
    @fields    = Field.where("plug_id=" + params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [ "elmtypes" => @elmtypes , "exposures" => @exposures , "fields" => @fields ] }
    end
  end
end
