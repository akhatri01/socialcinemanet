class URatingsController < ApplicationController
  # GET /u_ratings
  # GET /u_ratings.json
  def index
    @u_ratings = URating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @u_ratings }
    end
  end

  # GET /u_ratings/1
  # GET /u_ratings/1.json
  def show
    @u_rating = URating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @u_rating }
    end
  end

  # GET /u_ratings/new
  # GET /u_ratings/new.json
  def new
    @u_rating = URating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @u_rating }
    end
  end

  # GET /u_ratings/1/edit
  def edit
    @u_rating = URating.find(params[:id])
  end

  # POST /u_ratings
  # POST /u_ratings.json
  def create
    @u_rating = URating.new(params[:u_rating])

    respond_to do |format|
      if @u_rating.save
        format.html { redirect_to @u_rating, notice: 'U rating was successfully created.' }
        format.json { render json: @u_rating, status: :created, location: @u_rating }
      else
        format.html { render action: "new" }
        format.json { render json: @u_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /u_ratings/1
  # PUT /u_ratings/1.json
  def update
    @u_rating = URating.find(params[:id])

    respond_to do |format|
      if @u_rating.update_attributes(params[:u_rating])
        format.html { redirect_to @u_rating, notice: 'U rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @u_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /u_ratings/1
  # DELETE /u_ratings/1.json
  def destroy
    @u_rating = URating.find(params[:id])
    @u_rating.destroy

    respond_to do |format|
      format.html { redirect_to u_ratings_url }
      format.json { head :no_content }
    end
  end
end
