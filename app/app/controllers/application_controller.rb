class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?


  def index
    json_response({
      error: 'Cannot get'
    }, :not_found)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :role, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end


