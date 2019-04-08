require 'rails_helper'

include Warden::Test::Helpers

describe "ユーザーログイン機能", type: :system, js: true do
  before do
    FactoryBot.create(:user)
  end

  context "有効な情報を送信" do
    it "記事一覧ページにリダイレクトされる" do
      visit new_user_session_path
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      expect(current_path).to eq(root_path)
      expect(page).to have_content "記事一覧"
    end
  end

  context "無効な情報を送信するとエラーメッセージを返す" do
    it "" do

    end
  end
end