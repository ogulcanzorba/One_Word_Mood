class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Remove the commented-out or unsupported line unless custom code is written to handle browser version checking
  # allow_browser versions: :modern  # If this is unnecessary, remove it

  # Global error handling, filters, etc., can go here.

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :handle ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :handle ])
  end
end
