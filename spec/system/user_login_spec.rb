require 'rails_helper'

include Warden::Test::Helpers

describe "ユーザーログイン機能", type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
  end

  context "有効な情報を送信したとき" do
    it "記事一覧ページが表示される" do
      visit new_user_session_path
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"

      expect(page).to have_css("div.alert.alert-success", text: "ログインしました。")
      expect(page).to have_content "記事一覧"
      expect(page).to have_content "#{@user.name}"
    end
  end

  context "無効な情報を送信したとき" do
    it "メールアドレスが無効" do
      visit new_user_session_path
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: @user.password
      click_button "ログイン"

      expect(page).to have_css("div.alert")
    end

    it "パスワードが無効" do
      visit new_user_session_path
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: ""
      click_button "ログイン"

      expect(page).to have_css("div.alert")
    end
  end
end