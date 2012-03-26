module RequestMacros
  
  def login_user(roles_mask)
    visit login_path
    fill_in "Username", :with => @user.username
    fill_in "Password", :with => @user.password
    click_button "Log in"
  end
  
end