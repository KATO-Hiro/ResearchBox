require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = @user.posts.new(title: "Title", author: "Author", year: Date.today.year, user_id: @user.id)
  end

  context "投稿が有効である時" do
    it "有効な投稿の検証" do
      expect(@post).to be_valid
    end
  end

  context "投稿が無効である時" do
    it "ユーザーidの存在性" do
      @post.user_id = ""
      expect(@post).not_to be_valid
    end

    it "タイトルの存在性" do
      @post.title = ""
      expect(@post).not_to be_valid
    end

    it "著者の存在性" do
      @post.author = ""
      expect(@post).not_to be_valid
    end

    it "年代の存在性" do
      @post.year = ""
      expect(@post).not_to be_valid
    end
  end
end
