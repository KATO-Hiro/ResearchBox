require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it "有効なユーザーの検証" do
    expect(@user).to be_valid
  end

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
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save!
    expect(duplicate_user).not_to be_valid
  end

  it "メールアドレスの小文字変換" do
    @user.email = "TEst@EmaIL.com"
    @user.save!
    expect(@user.reload.email).to eq "test@email.com"
  end

  it "パスワードの存在性" do
    @user.password = @user.password_confirmation = ""
    expect(@user).not_to be_valid
  end

  it "パスワードの最小長さ" do
    @user.password = @user.password_confirmation = "a"*5
    expect(@user).not_to be_valid
  end
end
