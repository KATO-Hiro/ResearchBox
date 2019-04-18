class StocksController < ApplicationController
  before_action :authenticate_user! #ログインユーザーかどうかの検証

  def create
    @user = Post.find_by(id: params[:post_id]).user
    @stock = current_user.stocks.build(post_id: params[:post_id])
    if @user.id == @stock.user.id
      flash[:alert] = "自分の記事はストックできません。"
      redirect_back(fallback_location: root_path)
    else
      @stock.save
      flash[:notice] = "記事をストックしました。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @stock = current_user.stocks.find_by(post_id: params[:post_id])
    @stock.destroy
    flash[:notice] = "ストックを削除しました。"
    redirect_back(fallback_location: root_path)
  end
end
