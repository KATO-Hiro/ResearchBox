class StaticPagesController < ApplicationController

  def home
    @posts = Post.all.page(params[:page]).per(6)
  end

  def about
  end
end
