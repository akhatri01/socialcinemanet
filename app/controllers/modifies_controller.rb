class ModifiesController < ApplicationController
  # GET /modifies
  # GET /modifies.json
  def index
    @modifies = Modify.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @modifies }
    end
  end

  # GET /modifies/1
  # GET /modifies/1.json
  def show
    @modify = Modify.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @modify }
    end
  end

  # GET /modifies/new
  # GET /modifies/new.json
  def new
    @modify = Modify.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @modify }
    end
  end

  # GET /modifies/1/edit
  def edit
    @modify = Modify.find(params[:id])
  end

  # POST /modifies
  # POST /modifies.json
  def create
    @modify = Modify.new(params[:modify])

    respond_to do |format|
      if @modify.save
        format.html { redirect_to @modify, notice: 'Modify was successfully created.' }
        format.json { render json: @modify, status: :created, location: @modify }
      else
        format.html { render action: "new" }
        format.json { render json: @modify.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /modifies/1
  # PUT /modifies/1.json
  def update
    @modify = Modify.find(params[:id])

    respond_to do |format|
      if @modify.update_attributes(params[:modify])
        format.html { redirect_to @modify, notice: 'Modify was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modifies/1
  # DELETE /modifies/1.json
  def destroy
    @modify = Modify.find(params[:id])
    @modify.destroy

    respond_to do |format|
      format.html { redirect_to modifies_url }
      format.json { head :no_content }
    end
  end
end
