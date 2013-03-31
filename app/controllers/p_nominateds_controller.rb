class PNominatedsController < ApplicationController
  # GET /p_nominateds
  # GET /p_nominateds.json
  def index
    @p_nominateds = PNominated.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @p_nominateds }
    end
  end

  # GET /p_nominateds/1
  # GET /p_nominateds/1.json
  def show
    @p_nominated = PNominated.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @p_nominated }
    end
  end

  # GET /p_nominateds/new
  # GET /p_nominateds/new.json
  def new
    @p_nominated = PNominated.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @p_nominated }
    end
  end

  # GET /p_nominateds/1/edit
  def edit
    @p_nominated = PNominated.find(params[:id])
  end

  # POST /p_nominateds
  # POST /p_nominateds.json
  def create
    @p_nominated = PNominated.new(params[:p_nominated])

    respond_to do |format|
      if @p_nominated.save
        format.html { redirect_to @p_nominated, notice: 'P nominated was successfully created.' }
        format.json { render json: @p_nominated, status: :created, location: @p_nominated }
      else
        format.html { render action: "new" }
        format.json { render json: @p_nominated.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /p_nominateds/1
  # PUT /p_nominateds/1.json
  def update
    @p_nominated = PNominated.find(params[:id])

    respond_to do |format|
      if @p_nominated.update_attributes(params[:p_nominated])
        format.html { redirect_to @p_nominated, notice: 'P nominated was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @p_nominated.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /p_nominateds/1
  # DELETE /p_nominateds/1.json
  def destroy
    @p_nominated = PNominated.find(params[:id])
    @p_nominated.destroy

    respond_to do |format|
      format.html { redirect_to p_nominateds_url }
      format.json { head :no_content }
    end
  end
end
