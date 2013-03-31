class OscarsController < ApplicationController
  # GET /oscars
  # GET /oscars.json
  def index
    @oscars = Oscar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @oscars }
    end
  end

  # GET /oscars/1
  # GET /oscars/1.json
  def show
    @oscar = Oscar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @oscar }
    end
  end

  # GET /oscars/new
  # GET /oscars/new.json
  def new
    @oscar = Oscar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @oscar }
    end
  end

  # GET /oscars/1/edit
  def edit
    @oscar = Oscar.find(params[:id])
  end

  # POST /oscars
  # POST /oscars.json
  def create
    @oscar = Oscar.new(params[:oscar])

    respond_to do |format|
      if @oscar.save
        format.html { redirect_to @oscar, notice: 'Oscar was successfully created.' }
        format.json { render json: @oscar, status: :created, location: @oscar }
      else
        format.html { render action: "new" }
        format.json { render json: @oscar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /oscars/1
  # PUT /oscars/1.json
  def update
    @oscar = Oscar.find(params[:id])

    respond_to do |format|
      if @oscar.update_attributes(params[:oscar])
        format.html { redirect_to @oscar, notice: 'Oscar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @oscar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oscars/1
  # DELETE /oscars/1.json
  def destroy
    @oscar = Oscar.find(params[:id])
    @oscar.destroy

    respond_to do |format|
      format.html { redirect_to oscars_url }
      format.json { head :no_content }
    end
  end
end
