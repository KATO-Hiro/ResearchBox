class StaticPagesController < ApplicationController

  def home
    items_per_page = 6
    @posts = Post.all.page(params[:page]).per(items_per_page)

    #stockされた数が多い順に投稿を並べ替えて返す(人気の記事)
    @stock_count_id = Stock.group(:post_id).order('count_post_id DESC').count(:post_id).keys
    @stock_count_post_array = @stock_count_id.map{|id| Post.find(id)}
    @stock_count_posts = Kaminari.paginate_array(@stock_count_post_array).page(params[:page]).per(items_per_page)

    #検索フォームから入力されたキーワード(タイトルまたは著者)を含む記事を返す
    @search = Post.ransack(params[:q])
    if params[:q].nil?
      @search_posts = []
    else
      @search_posts = @search.result.page(params[:page]).per(items_per_page)
    end

    @stocks = Stock.all
  end

  def about
  end
end
