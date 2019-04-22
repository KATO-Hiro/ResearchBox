class PostsController < ApplicationController
  #ログインユーザーであるか検証
  before_action :authenticate_user!

  #記事編集権限を持っているか検証
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    items_per_page = 6
    @post = Post.find(params[:id])
    @stock = Stock.new
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(items_per_page)
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "記事を編集しました。"
      redirect_to root_path
    else
      render 'posts/edit'
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "記事を投稿しました。"
      redirect_to current_user
    else
      render 'posts/new'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:notice] = "記事を削除しました。"
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :author, :year, :abstract,
                                    :superiority, :technique, :verification,
                                     :discussion, :suggestion, {figures: []})
    end

    def correct_user
      @post = Post.find(params[:id])
      @user = @post.user
      unless @user == current_user
      flash[:alert] = "権限がありません"
      redirect_to root_path
      end
    end
end
