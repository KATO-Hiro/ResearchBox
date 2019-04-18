require 'rails_helper'
include Warden::Test::Helpers

describe "ストック削除機能", type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)

    @other_user = FactoryBot.create(:user, email: "other@example.com")
    @other_user_post = FactoryBot.create(:post, user: @other_user)
    @stock = FactoryBot.create(:stock, post: @other_user_post, user: @user)
    sign_in @user
  end

  context "記事一覧ページにアクセスした時" do
    it "他人の投稿のストックの削除に成功する" do
      visit root_path
      click_link nil, href: post_stock_path(post_id: @other_user_post.id, id: @user.id)
      expect(page).to have_css("div.alert.alert-success")
    end
  end

  context "記事詳細ページにアクセスした時" do
    it "他人の投稿のストックの削除に成功する" do
      visit user_path(id: @other_user.id)
      click_link nil, href: post_stock_path(post_id: @other_user_post.id, id: @user.id)
      expect(page).to have_css("div.alert.alert-success")
    end
  end
end
