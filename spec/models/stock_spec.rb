require 'rails_helper'

RSpec.describe Stock, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    @stock = FactoryBot.create(:stock, post: @post, user: @user)
  end

  context "有効なストック" do
    it "有効なストックの検証" do
      expect(@stock).to be_valid
    end
  end

  context "無効なストック" do
    it "ユーザーidの存在性" do
      @stock.user_id = ""
      expect(@stock).not_to be_valid
    end

    it "記事idの存在性" do
      @stock.post_id = ""
      expect(@stock).not_to be_valid
    end

    it "ユーザーidと記事idの一意性" do
      duplicate_stock = FactoryBot.build(:stock, post: @post, user: @user)
      expect(duplicate_stock).not_to be_valid
    end
  end
end
