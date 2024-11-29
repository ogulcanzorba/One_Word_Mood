class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern  # Commented out or ensure this method is defined

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:handle])
    devise_parameter_sanitizer.permit(:account_update, keys: [:handle])
  end
end
