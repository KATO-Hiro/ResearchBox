require 'rails_helper'

include Warden::Test::Helpers

describe "ユーザーアカウント編集機能", type: :system, js: true do

  before do
    @user = FactoryBot.create(:user)
  end

end