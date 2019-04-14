require 'rails_helper'

include Warden::Test::Helpers

describe "記事投稿機能", type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    sign_in @user
    visit edit_post_path(id: @post.id)
  end

  it "記事が削除される" do
    expect {
      click_button "投稿を削除する"
      page.accept_confirm 'Are you sure?'
      expect(page).to have_css("div.alert.alert-success")
    }.to change(@user.posts, :count).by(-1)
  end
end