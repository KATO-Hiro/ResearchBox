require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)

    @other_user = FactoryBot.create(:user, email: "other@example.com")
    @other_user_post = FactoryBot.create(:post, user: @other_user)
  end

  describe "ストック生成機能" do
    context "非ログイン時" do
      it "ストックの生成に失敗し、ログインページにリダイレクトされる" do
        expect {
          post :create, params: {post_id: @post.id}
        }.to change(@user.stocks, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "自分の投稿のストックに失敗する" do
        sign_in @user
        expect {
          post :create, params: {post_id: @post.id}
        }.to change(@user.stocks, :count).by(0)
      end

      it "他人の投稿のストックに成功する" do
        sign_in @user
        expect {
          post :create, params: {post_id: @other_user_post.id}
        }.to change(@user.stocks, :count).by(1)
      end
    end
  end

  describe "ストック削除機能" do
    context "非ログイン時" do
      it "ストックの削除に失敗し、ログインページにリダイレクトされる" do
        @stock = FactoryBot.create(:stock, post: @other_user_post, user: @user)
        expect {
          delete :destroy, params: {post_id: @stock.post.id, id: @stock.user.id}
        }.to change(@user.stocks, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "ストックの削除に成功する" do
        sign_in @user
        @stock = FactoryBot.create(:stock, post: @other_user_post, user: @user)
        expect {
          delete :destroy, params: {post_id: @stock.post, id: @stock.user.id}
        }.to change(@user.stocks, :count).by(-1)
      end
    end
  end
end
