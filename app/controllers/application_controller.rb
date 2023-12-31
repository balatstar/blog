class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio photo])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio photo])
  end

  helper_method :current_user
end
