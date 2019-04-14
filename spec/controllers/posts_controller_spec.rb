require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, email: "other@example.com")
    @post = FactoryBot.create(:post, user: @user)
  end

  describe "#show" do
    context "非ログイン時" do
      it "ログインページにリダイレクトされる" do
        get :show, params: {id: @post.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "記事詳細ページが表示される" do
        sign_in @user
        get :show, params: {id: @post.id}
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#edit" do
    context "非ログイン時" do
      it "ログインページにリダイレクトされる" do
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "記事編集ページが表示される" do
        sign_in @user
        get :edit, params: {id: @post.id}
        expect(response).to have_http_status(:success)
      end

      it "他のユーザーがアクセスしたらリダイレクトさせる" do
        sign_in @other_user
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#new" do
    context "非ログイン時" do
      it "ログインページにリダイレクトされる" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "新規記事投稿ページが表示される" do
        sign_in @user
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#create" do
    context "非ログイン時" do
      it "記事の投稿に失敗し、ログインページにリダイレクトされる" do
        post_params = FactoryBot.attributes_for(:post)
        expect {
          post :create, params: {post: post_params}
        }.to change(@user.posts, :count).by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "無効な値を入力すると記事を投稿に失敗する" do
        sign_in @user
        post_params = FactoryBot.attributes_for(:post, title: "")
        expect {
          post :create, params: {post: post_params}
        }.to change(@user.posts, :count).by(0)
      end

      it "記事を投稿できる" do
        sign_in @user
        post_params = FactoryBot.attributes_for(:post)
        expect {
          post :create, params: {post: post_params}
        }.to change(@user.posts, :count).by(1)
      end
    end
  end

  describe "#update" do
    context "非ログイン時" do
      it "記事の更新に失敗し、ログインページにリダイレクトされる" do
        post_params = FactoryBot.attributes_for(:post, title: "New Title")
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.title).to eq(@post.title)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "無効な値を入力すると記事の更新に失敗する" do
        sign_in @user
        post_params = FactoryBot.attributes_for(:post, title: "")
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.title).to eq(@post.title)
      end

      it "記事の更新に成功し、ユーザー詳細ページにリダイレクトされる" do
        sign_in @user
        post_params = FactoryBot.attributes_for(:post, title: "New Title")
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.title).to eq("New Title")
        expect(response).to redirect_to user_path(@user)
      end

      it "他のユーザーがアクセスしたらリダイレクトさせる" do
        sign_in @other_user
        post_params = FactoryBot.attributes_for(:post, title: "Your Post was Hijacked")
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.title).to eq(@post.title)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#destroy" do
    context "非ログイン時" do
      it "記事の削除に失敗し、ログインページにリダイレクトされる" do
        expect {
          delete :destroy, params: {id: @post.id}
        }.not_to change(Post, :count)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "記事の削除に成功し、ユーザー詳細ページにリダイレクトされる" do
        sign_in @user
        expect {
          delete :destroy, params: {id: @post.id}
        }.to change(@user.posts, :count).by(-1)
        expect(response).to redirect_to user_path(@user)
      end

      it "他のユーザーがアクセスしたらリダイレクトさせる" do
        sign_in @other_user
        expect {
          delete :destroy, params: {id: @post.id}
        }.not_to change(Post, :count)
      end
    end
  end
end
