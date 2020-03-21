class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from Pundit::NotAuthorizedError, with: :forbidden
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :unprocessable_entity



  protected

  def unprocessable_entity(exception)
    render status: :unprocessable_entity, json: {
      id: 'unprocessable_entity',
      message: exception.message
    }
  end

  def not_found(exception)
    render status: :not_found, json: {
      id: 'not_found',
      message: exception.message
    }
  end

  def forbidden
    render status: :forbidden, json: {
      id: 'forbidden',
      message: 'Você não tem acesso a este recurso.'
    }
  end

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :role, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end


