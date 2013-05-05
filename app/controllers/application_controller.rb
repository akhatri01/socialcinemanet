class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_logged_in
  
  private 
  def set_logged_in
    @logged_in = logged_in?
    if(@logged_in)
      @current_user =  current_user
    end
  end
  
  private
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end
  
  def logged_in?
    !!current_user
  end
  
end
