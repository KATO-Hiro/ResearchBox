class CommentsController < ApplicationController
  #ログイン済みユーザーであるかどうか検証
  before_action :authenticate_user!

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:notice] = "記事にコメントしました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "コメントに失敗しました。再度やり直してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
