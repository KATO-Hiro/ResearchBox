require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = FactoryBot.create(:user)
  end

  describe "#index" do
    it "記事一覧ページが表示される" do
      sign_in @user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    context "非ログイン時" do
      it "ログインページにリダイレクトされる" do
        get :show, params: {id: @user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン時" do
      it "ユーザー詳細ページが表示される" do
        sign_in @user
        expect(@user).to eq(controller.current_user)
        get :show, params: {id: @user.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
