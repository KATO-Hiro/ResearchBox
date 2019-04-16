class StaticPagesController < ApplicationController

  def home
    @posts = Post.all.page(params[:page]).per(6)
    @search = Post.ransack(params[:q])
    @search_posts = @search.result.page(params[:page]).per(6)
  end

  def about
  end
end
