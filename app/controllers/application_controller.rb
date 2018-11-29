class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin!
    unless authenticate_user! && current_user.admin
      flash[:error] = "You are not authorized to view that page"
      redirect_to controller: :wiki_page, action: :index
    end
    true
  end

  def user_banned!
    # write some stuff that checks if the user is banned
    request.remote_ip # check it with a list of bad users

  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
