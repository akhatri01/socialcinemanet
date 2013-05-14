class UsersController < ApplicationController
  layout :resolve_layout
  
  private
  def resolve_layout
    case action_name
    when "register", "create_user", "login", "new_session"
      "users"
    else
      "application"
    end
  end
  
  public
  def register
    if !logged_in?
      @user = User.new
    else
      redirect_to root_url
    end
  end
  
  def create_user
    @user = User.new(params[:user])
    if @user.save
      @welcome = true
      session[:current_user_id] = @user.id
      redirect_to root_url
    else
      render 'register'
    end
  end
  
  def login
    @user = User.new
  end
  
  def new_session
    @user = User.new(params[:user])
    @user = User.where "email=? AND password=?", @user.email, @user.password
    if @user.size == 1
      @user = @user[0]
      session[:current_user_id] = @user.id
      redirect_to root_url
    else
      @user = User.new(params[:user])
      @error = true
      render 'login'
    end
  end
  
  def myaccount
    if !logged_in?
      redirect_to login_url
    end
    @message = params[:message]
    @error = params[:error]
    @edit_user = @current_user
  end
  
  def myaccountedit
    if !logged_in?
      redirect_to login_url
    end
    if @current_user.update_attributes(params[:user])
      redirect_to myaccount_path(:message => "Account updated.")
    else
      redirect_to myaccount_path(:error => "Account update error.")
    end
  end
  
  def change_password
    if !logged_in?
      redirect_to login_url
    end
    @error = params[:error]
  end
  
  def change_password_action
    if (params[:current_password] == '' || params[:new_password] == '' || params[:new_password_confirm] == '')
      redirect_to change_password_path(:error => "Fill in all fields.")
    elsif (params[:current_password] != @current_user.password)
      redirect_to change_password_path(:error => "Current password is incorrect.")
    elsif params[:new_password] != params[:new_password_confirm]
      redirect_to change_password_path(:error => "New password confirmation mismatch.")
    else
      @current_user.password = params[:new_password]
      @current_user.save
      redirect_to myaccount_path(:message => "Password updated.")
    end
  end
  
  def delete_curr_user
    @archive_user = CreateUsersArchive.new
    @archive_user.id = @current_user.id
    @archive_user.fname = @current_user.fname
    @archive_user.mname = @current_user.mname
    @archive_user.lname = @current_user.lname
    @archive_user.dob = @current_user.dob
    @archive_user.password = @current_user.password
    @archive_user.created_at = @current_user.created_at
    @archive_user.updated_at = @current_user.updated_at
    if @archive_user.save
      @current_user.destroy
    end
    redirect_to root_url
  end
  
  def logout
    session[:current_user_id] = nil
    redirect_to root_url
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.limit(10).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
