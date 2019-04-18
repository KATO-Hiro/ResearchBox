require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)

    @other_user = FactoryBot.create(:user, email: "other@example.com")
    @other_user_post = FactoryBot.create(:post, user: @other_user)
  end

  describe "コメント生成機能" do
    context "非ログイン時" do
      it "コメントの作成に失敗し、ログインページにリダイレクトされる" do
        comment_params = FactoryBot.attributes_for(:comment, content: "Content")
        expect {
          post :create, params: {post_id: @post.id, comment: comment_params}
        }.to change(@post.comments, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "正しい内容を入力し、コメントの作成に成功する" do
        comment_params = FactoryBot.attributes_for(:comment, content: "Content")
        sign_in @user
        expect {
          post :create, params: {post_id: @post.id, comment: comment_params}
        }.to change(@post.comments, :count).by(1)
      end

      it "不正な内容を入力し、コメントの作成に失敗する" do
        comment_params = FactoryBot.attributes_for(:comment, content: "")
        sign_in @user
        expect {
          post :create, params: {post_id: @post.id, comment: comment_params}
        }.to change(@post.comments, :count).by(0)
      end
    end
  end
end
