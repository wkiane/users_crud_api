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
    @user.update(user_params)
    json_response(@user)
  end

  def show
    authorize @user
    json_response(@user)
  end

  def update
    authorize @user
    @user.update(user_params)


    json_response(@user)
  end

  def destroy
    authorize @user
    @user.discard
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :password, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
