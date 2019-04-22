class UsersController < ApplicationController
  #ログイン済みユーザーであるか検証
  before_action :authenticate_user!

  def index
    items_per_page = 8
    @users = User.page(params[:page]).per(items_per_page)
    @search = User.ransack(params[:q])
    @search_users = @search.result.page(params[:page]).per(items_per_page)
  end

  def show
    items_per_page = 6
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page]).per(items_per_page)
    @stocked_posts = Kaminari.paginate_array(@user.stocked_posts).page(params[:page]).per(items_per_page)
  end
end
