require 'rails_helper'

include Warden::Test::Helpers

describe "記事投稿機能", type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    sign_in @user
    visit edit_post_path(id: @post.id)
  end

  context "無効な情報を送信したとき" do
    it "記事の投稿に失敗する" do
      fill_in "タイトル", with: ""
      fill_in "著者", with: ""
      fill_in "どんな論文？", with: ""
      find("option[value='2001']").select_option
      fill_in "先行研究と比べてどこがすごい？", with: "Superiority"
      fill_in "技術や手法で重要な点はどこ？", with: "Technique"
      fill_in "どうやって有効だと検証した？", with: "Verification"
      fill_in "議論はある？", with: "Discussion"
      fill_in "次に読むべき論文は？", with: "Suggestion"
      click_button "更新する"

      expect(page).to have_css("div#error_explanation")
    end
  end

  context "有効な情報を送信したとき" do
    it "ユーザー詳細ページにリダイレクトされる" do
      fill_in "タイトル", with: "Title"
      fill_in "著者", with: "Author"
      fill_in "どんな論文？", with: "Abstract"
      find("option[value='2001']").select_option
      fill_in "先行研究と比べてどこがすごい？", with: "Superiority"
      fill_in "技術や手法で重要な点はどこ？", with: "Technique"
      fill_in "どうやって有効だと検証した？", with: "Verification"
      fill_in "議論はある？", with: "Discussion"
      fill_in "次に読むべき論文は？", with: "Suggestion"
      click_button "更新する"

      expect(page).to have_css("div.alert.alert-success")
    end
  end

end