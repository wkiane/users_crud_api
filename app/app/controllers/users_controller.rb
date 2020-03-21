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

  def user_params
    params.permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

  def admin_params
    params.permit(:first_name, :last_name, :password, :password_confirmation, :email, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
