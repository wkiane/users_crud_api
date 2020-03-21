class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :authenticate_user!
  
  def index
    @users = User.where(discarded_at: [nil, ""]).all
    authorize @users
    json_response(@users)
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

  def set_user
    @user = User.find(params[:id])
  end
end
