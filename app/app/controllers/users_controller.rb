class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @users = User.where(discarded_at: [nil, ""]).all
    authorize @users
    json_response(@users)
  end


  def update
    authorize @user


    if password_validation_fail
      return json_response({ error: password_validation_fail }, :unprocessable_entity)
    end

    if is_admin(current_user)
      @user.update(admin_params)
    else 
      @user.update(user_params)
    end

    json_response(@user)
  end

  def show
    authorize @user
    json_response(@user)
  end


  def destroy
    authorize @user
    @user.discard
  end

  private

  def is_admin(user)
    if user.role == "admin"
      true
    else
      false
    end
  end

  def password_validation_fail
    if params[:password] && params[:password_confirmation].blank?
      "Campo confirmação de senha deve ser preenchido"
    elsif params[:password] != params[:password_confirmation]
      "Campo confirmação de senha deve ser idêntico ao campo senha"
    end
  end

  def user_params
    params.permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

  def admin_params
    params.permit(:first_name, :last_name, :password, :password_confirmation, :email, :role)
  end

  def set_user
    @user = User.where(id: params[:id], discarded_at: [nil, ""]).first

    if @user.nil?
      json_response({ id: "not_found", message: "Usuário não encontrado" }, :not_found)
    end
  end
end
