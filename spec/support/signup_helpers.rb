module SignupHelpers

  def sign_up__with(name, email, password, password_confirmation)
    visit new_user_registration_path
    fill_in "名前", with: name
    fill_in "メールアドレス", with: email
    fill_in "パスワード", with: password
    fill_in "確認用パスワード", with: password_confirmation
    click_button "Sign up"
  end

end
