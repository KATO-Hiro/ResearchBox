require 'rails_helper'

include Warden::Test::Helpers

describe "ユーザー詳細ページ、ユーザー一覧ページのUI", type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, email: "other@example.com")
  end

  describe "ユーザー詳細表示機能" do
    context "カレントユーザーから見た時" do
      it "アカウント設定・記事投稿ページへのリンクが表示される" do
        sign_in @user
        visit user_path(id: @user.id)
        expect(page).to have_link("アカウント設定", href: edit_user_registration_path)
        expect(page).to have_link("投稿する", href: new_post_path)
      end

      it "投稿した記事数が表示される" do
        sign_in @user
        visit user_path(id: @user.id)
        expect(page).to have_content("投稿した記事(#{@user.posts.count})")
      end
    end

    context "他のユーザーから見た時" do
      it "アカウント設定・記事投稿ページへのリンクが表示されない" do
        sign_in @other_user
        visit user_path(id: @user.id)
        expect(page).not_to have_link("アカウント設定", href: edit_user_registration_path)
        expect(page).not_to have_link("投稿する", href: new_post_path)
      end

      it "投稿した記事数が表示される" do
        sign_in @other_user
        visit user_path(id: @other_user.id)
        expect(page).to have_content("投稿した記事(#{@other_user.posts.count})")
      end
    end
  end

  describe "ユーザー一覧表示機能" do

  end
end