require 'rails_helper'
include Warden::Test::Helpers

describe "コメント生成機能", type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    sign_in @user
  end

  context "有効な情報を送信した時" do
    it "投稿へのコメントが成功する" do
      visit post_path(id: @post.id)
      click_button "コメントする"
      fill_in "内容", with: "Comment"
      click_button "この内容でコメントする"
      expect(page).to have_css("div.alert.alert-success")
      expect(page).to have_content("Comment")
    end
  end

  context "無効な情報を送信した時" do
    it "投稿へのコメントが失敗する" do
      visit post_path(id: @post.id)
      click_button "コメントする"
      fill_in "内容", with: ""
      click_button "この内容でコメントする"
      expect(page).to have_css("div.alert.alert-danger")
    end
  end
end
