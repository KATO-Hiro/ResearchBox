require 'rails_helper'

RSpec.describe User, type: :model do
  include CarrierWave::Test::Matchers

  before do
    @user = FactoryBot.create(:user)
  end

  context "ユーザーが有効であるとき" do
    it "有効なユーザーの検証" do
      expect(@user).to be_valid
    end

    it "メールアドレスの小文字変換" do
      @user.email = "TEst@ExAMPle.com"
      @user.save!
      expect(@user.reload.email).to eq "test@example.com"
    end

    it "指定した形式でアバターが設定される" do
      formats = %w(jpg jpeg gif png)
      formats.each do |format|
        image_path = File.join(Rails.root, "spec/sample_avatars/sample.#{format}")
        user_with_avatar = FactoryBot.build(:user, email: "avatar@example.com" , avatar: File.open(image_path))
        expect(user_with_avatar).to be_valid
      end
    end
  end

  context "ユーザーが無効であるとき" do
    it "名前の存在性" do
      @user.name = ""
      expect(@user).not_to be_valid
    end

    it "ユーザー名の長さ" do
      @user.name = "a"*51
      expect(@user).not_to be_valid
    end

    it "メールアドレスの存在性" do
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "メールアドレスの一意性" do
      user = FactoryBot.build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end

    it "パスワードの存在性" do
      @user.password = @user.password_confirmation = ""
      expect(@user).not_to be_valid
    end

    it "パスワードの最小長さ" do
      @user.password = @user.password_confirmation = "a"*5
      expect(@user).not_to be_valid
    end

    it "アバター画像の形式" do
      image_path = File.join(Rails.root, "spec/sample_avatars/sample.rb")
      user_with_invalid_avatar = FactoryBot.build(:user, email: "avatar_invalid@example.com" , avatar: File.open(image_path))
      expect(user_with_invalid_avatar).not_to be_valid
    end
  end
end
