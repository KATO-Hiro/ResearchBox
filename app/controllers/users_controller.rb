class UsersController < ApplicationController
before_action :authenticate_user!

  def index
    @users = User.page(params[:page]).per(6)
    @search = User.ransack(params[:q])
    @search_users = @search.result.page(params[:page]).per(6)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page]).per(6)
    @stocked_posts = Kaminari.paginate_array(@user.stocked_posts).page(params[:page]).per(6)
  end
end
