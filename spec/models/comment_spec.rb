require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @comment = FactoryBot.create(:comment, post: @post, user: @user)
  end

  context "有効なコメント" do
    it "有効なコメントの検証" do
      expect(@comment).to be_valid
    end
  end

  context "無効なコメント" do
    it "内容の存在性" do
      @comment.content = ""
      expect(@comment).not_to be_valid
    end

    it "文字数の制限" do
      @comment.content = "a"*141
      expect(@comment).not_to be_valid
    end

    it "ユーザーidの存在性" do
      @comment.user_id = ""
      expect(@comment).not_to be_valid
    end

    it "記事idの存在性" do
      @comment.post_id = ""
      expect(@comment).not_to be_valid
    end
  end
end
