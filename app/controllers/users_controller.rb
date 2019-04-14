class UsersController < ApplicationController
before_action :authenticate_user!

  def index
    @users = User.page(params[:page]).per(6)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page]).per(6)
  end
end
