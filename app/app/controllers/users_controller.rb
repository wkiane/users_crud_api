class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.where(discarded_at: [nil, ""]).all
    json_response(@users)
  end

  def show
    json_response(@user)
  end

  def destroy
    @user.discard
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
