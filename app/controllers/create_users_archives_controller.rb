class CreateUsersArchivesController < ApplicationController
  # GET /create_users_archives
  # GET /create_users_archives.json
  def index
    @create_users_archives = CreateUsersArchive.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @create_users_archives }
    end
  end

  # GET /create_users_archives/1
  # GET /create_users_archives/1.json
  def show
    @create_users_archive = CreateUsersArchive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @create_users_archive }
    end
  end

  # GET /create_users_archives/new
  # GET /create_users_archives/new.json
  def new
    @create_users_archive = CreateUsersArchive.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @create_users_archive }
    end
  end

  # GET /create_users_archives/1/edit
  def edit
    @create_users_archive = CreateUsersArchive.find(params[:id])
  end

  # POST /create_users_archives
  # POST /create_users_archives.json
  def create
    @create_users_archive = CreateUsersArchive.new(params[:create_users_archive])

    respond_to do |format|
      if @create_users_archive.save
        format.html { redirect_to @create_users_archive, notice: 'Create users archive was successfully created.' }
        format.json { render json: @create_users_archive, status: :created, location: @create_users_archive }
      else
        format.html { render action: "new" }
        format.json { render json: @create_users_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /create_users_archives/1
  # PUT /create_users_archives/1.json
  def update
    @create_users_archive = CreateUsersArchive.find(params[:id])

    respond_to do |format|
      if @create_users_archive.update_attributes(params[:create_users_archive])
        format.html { redirect_to @create_users_archive, notice: 'Create users archive was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @create_users_archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /create_users_archives/1
  # DELETE /create_users_archives/1.json
  def destroy
    @create_users_archive = CreateUsersArchive.find(params[:id])
    @create_users_archive.destroy

    respond_to do |format|
      format.html { redirect_to create_users_archives_url }
      format.json { head :no_content }
    end
  end
end
