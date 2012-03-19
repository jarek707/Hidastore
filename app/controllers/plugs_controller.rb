class PlugsController < ApplicationController
  # GET /plugs
  # GET /plugs.json
  def index
    @plugs = Plug.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plugs }
    end
  end

  # GET /plugs/1
  # GET /plugs/1.json
  def show
    @plug = Plug.find(params[:id])
    logger.debug @plug.to_json()
    #@plugs = Plug.where("legend!='Root' AND legend!='Plugins' AND legend!='Fields'")
    #@plugs = Plug.where("legend!='Root'")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plug }
    end
  end

  # GET /plugs/new
  # GET /plugs/new.json
  def new
    # need root plug to start the system
    if Plug.where("legend='Root'").length == 0
      @root = Plug.new({:tab_name => "root_no_tab", :legend => "Root"});
      @root.save
    end
    @plug = Plug.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plug }
    end
  end

  # GET /plugs/1/edit
  def edit
    @plug = Plug.find(params[:id])
  end

  # POST /plugs
  # POST /plugs.json
  def create
    @plug = Plug.new(params[:plug])
    @plug.generate (params[:plug])

    respond_to do |format|
      if @plug.save
        format.html { redirect_to @plug, notice: 'Plug was successfully created.' }
        format.json { render json: @plug, status: :created, location: @plug }
      else
        format.html { render action: "new" }
        format.json { render json: @plug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plugs/1
  # PUT /plugs/1.json
  def update
    @plug = Plug.find(params[:id])

    respond_to do |format|
      if @plug.update_attributes(params[:plug])
        format.html { redirect_to @plug, notice: 'Plug was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @plug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plugs/1
  # DELETE /plugs/1.json
  def destroy
    @plug = Plug.find(params[:id])
    @plug.destroy

    respond_to do |format|
      format.html { redirect_to plugs_url }
      format.json { head :ok }
    end
  end
end
