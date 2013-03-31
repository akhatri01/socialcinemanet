class MNominatedsController < ApplicationController
  # GET /m_nominateds
  # GET /m_nominateds.json
  def index
    @m_nominateds = MNominated.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_nominateds }
    end
  end

  # GET /m_nominateds/1
  # GET /m_nominateds/1.json
  def show
    @m_nominated = MNominated.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_nominated }
    end
  end

  # GET /m_nominateds/new
  # GET /m_nominateds/new.json
  def new
    @m_nominated = MNominated.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_nominated }
    end
  end

  # GET /m_nominateds/1/edit
  def edit
    @m_nominated = MNominated.find(params[:id])
  end

  # POST /m_nominateds
  # POST /m_nominateds.json
  def create
    @m_nominated = MNominated.new(params[:m_nominated])

    respond_to do |format|
      if @m_nominated.save
        format.html { redirect_to @m_nominated, notice: 'M nominated was successfully created.' }
        format.json { render json: @m_nominated, status: :created, location: @m_nominated }
      else
        format.html { render action: "new" }
        format.json { render json: @m_nominated.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_nominateds/1
  # PUT /m_nominateds/1.json
  def update
    @m_nominated = MNominated.find(params[:id])

    respond_to do |format|
      if @m_nominated.update_attributes(params[:m_nominated])
        format.html { redirect_to @m_nominated, notice: 'M nominated was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_nominated.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_nominateds/1
  # DELETE /m_nominateds/1.json
  def destroy
    @m_nominated = MNominated.find(params[:id])
    @m_nominated.destroy

    respond_to do |format|
      format.html { redirect_to m_nominateds_url }
      format.json { head :no_content }
    end
  end
end
