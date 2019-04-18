require 'rails_helper'

include Warden::Test::Helpers

describe "記事詳細ページ、記事一覧ページのUI", type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user, email: "other@example.com")
    @post = FactoryBot.create(:post, user: @user)
    @additional_post = FactoryBot.create(:post, user: @user, title: "Additional Post for Search")
  end

  describe "記事詳細表示機能" do
    context "カレントユーザーから見た時" do
      it "編集と削除を行うためのリンクが表示される" do
        sign_in @user
        visit post_path(id: @post.id)
        expect(page).to have_link(nil, href: edit_post_path(id: @post.id))
        expect(page).to have_selector 'a[data-method=delete]'
      end
    end

    context "他のユーザーから見た時" do
      it "編集と削除を行うためのリンクが表示されず、ストックを行うためのリンクが表示される" do
        sign_in @other_user
        visit post_path(id: @post.id)
        expect(page).not_to have_link(nil, href: edit_post_path(id: @post.id))
        expect(page).not_to have_selector 'a[data-method=delete]'
        expect(page).to have_link(nil, href: post_stocks_path(post_id: @post.id))
      end
    end
  end

  describe "記事一覧表示機能" do
    it "記事詳細ページ・ユーザー詳細ページ・編集と削除を行うためのリンクを含んでいる" do
      sign_in @user
      visit root_path
      expect(page).to have_link(@user.name, href: user_path(id: @user.id))
      expect(page).to have_link(@post.title, href: post_path(id: @post.id))
      expect(page).to have_link("もっと読む", href: post_path(@post.id))
      expect(page).to have_link(nil, href: edit_post_path(id: @post.id))
      expect(page).to have_selector 'a[data-method=delete]'
    end
  end

  describe "記事検索機能" do
    it "指定された検索キーワードを含むタイトルの記事が表示される" do
      sign_in @user
      visit root_path
      fill_in nil, with: "Search"
      click_button "検索"
      expect(page).to have_content("Search")
      expect(page).not_to have_content("Title")
    end
  end
end