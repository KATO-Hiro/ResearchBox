require 'rails_helper'

include Warden::Test::Helpers

describe "新規ユーザー登録機能", type: :system, js: true do


  context "有効な情報を送信" do

    it "トップページにリダイレクトされる" do
      visit new_user_registration_path
      fill_in "名前", with: "Test User"
      fill_in "メールアドレス", with: "text@example.com"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      click_button "登録する"
      expect(current_path).to eq(root_path)
    end
  end

  context "無効な情報を送信" do

    it "エラーメッセージが出現" do
      visit new_user_registration_path
      fill_in "名前", with: ""
      fill_in "メールアドレス", with: "text@example.com"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      click_button "登録する"
      expect(page).to have_css('div#error_explanation')
    end
  end
end