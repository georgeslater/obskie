class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end

  def get_has_drafts

    if current_user.present?
      @hasDrafts = current_user.albums.select { | album | album.published == false }.size > 0
    else
      @hasDrafts = false
    end
  end

  #def lookup_ip_location
   # if Rails.env.development?
    #  Geocoder.search(request.remote_ip).first
    #else
     # request.location
    #end
  #end

  helper_method :forem_user
  helper_method :has_drafts
  #helper_method :lookup_ip_location

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_has_drafts

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end


end
