class StocksController < ApplicationController
  #ログインユーザーかどうかの検証
  before_action :authenticate_user!

  def create
    @user = Post.find(params[:post_id]).user
    if @user
      @stock = current_user.stocks.build(post_id: params[:post_id])
      if @user.id == @stock.user.id
        flash[:alert] = "自分の記事はストックできません。"
        redirect_back(fallback_location: root_path)
      else
        @stock.save
        flash[:notice] = "記事をストックしました。"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:alert] = "記事またはユーザーが見つかりませんでした。"
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
