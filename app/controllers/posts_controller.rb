class PostsController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def new
    @post = current_user.posts.build
  end

  def edit

  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "記事を投稿しました。"
      redirect_to @post.user
    else
      render 'posts/new'
    end
  end

  def destroy

  end

  private
    def post_params
      params.require(:post).permit(:title, :author, :year, :abstract, :superiority, :technique, :varifiaction, :discussion, :suggestion)
    end
end
