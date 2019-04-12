require 'rails_helper'

include Warden::Test::Helpers

describe "ユーザーアカウント編集機能", type: :system, js: true do

  before do
    image_path = File.join(Rails.root, "spec/sample_avatars/sample.jpg")
    @user = FactoryBot.create(:user, avatar: File.open(image_path))
    sign_in @user
    visit edit_user_registration_path
  end

  context "正しい情報を入力した時" do
    it "記事一覧ページにリダイレクトされる" do
      fill_in "名前", with: @user.name
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: ""
      fill_in "確認用パスワード", with: ""
      click_button "アカウントを更新する"
      expect(page).to have_css("div.alert.alert-success", text: "アカウント情報を変更しました。")
      expect(page).to have_content "記事一覧"
    end

    it "チェックボックスを入力するとアバターが削除されてデフォルトのアバターを使用" do
      expect(page).to have_css("img.user-avatar")
      check "user_remove_avatar"
      click_button "アカウントを更新する"
      expect(page).to have_css("div.alert.alert-success", text: "アカウント情報を変更しました。")
      visit edit_user_registration_path
      expect(page).to have_css("img.user-avatar-default")
    end
  end

  context "不正な情報を入力した時" do
    it "空の名前を入力" do
      fill_in "名前", with: ""
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: ""
      fill_in "確認用パスワード", with: ""
      click_button "アカウントを更新する"
      expect(page).to have_css("div#error_explanation")
    end
  end
end