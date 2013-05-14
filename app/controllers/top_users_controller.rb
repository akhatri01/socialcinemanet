class TopUsersController < ApplicationController
  # GET /top_users
  # GET /top_users.json
  def index
    @top_users = TopUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @top_users }
    end
  end

  # GET /top_users/1
  # GET /top_users/1.json
  def show
    @top_user = TopUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @top_user }
    end
  end

  # GET /top_users/new
  # GET /top_users/new.json
  def new
    @top_user = TopUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @top_user }
    end
  end

  # GET /top_users/1/edit
  def edit
    @top_user = TopUser.find(params[:id])
  end

  # POST /top_users
  # POST /top_users.json
  def create
    @top_user = TopUser.new(params[:top_user])

    respond_to do |format|
      if @top_user.save
        format.html { redirect_to @top_user, notice: 'Top user was successfully created.' }
        format.json { render json: @top_user, status: :created, location: @top_user }
      else
        format.html { render action: "new" }
        format.json { render json: @top_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /top_users/1
  # PUT /top_users/1.json
  def update
    @top_user = TopUser.find(params[:id])

    respond_to do |format|
      if @top_user.update_attributes(params[:top_user])
        format.html { redirect_to @top_user, notice: 'Top user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @top_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /top_users/1
  # DELETE /top_users/1.json
  def destroy
    @top_user = TopUser.find(params[:id])
    @top_user.destroy

    respond_to do |format|
      format.html { redirect_to top_users_url }
      format.json { head :no_content }
    end
  end
end
