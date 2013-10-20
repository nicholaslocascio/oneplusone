module OrganizationHelper
  
  def login_with(email, password)
    visit root_path
    click_link 'Login'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Login'
  end
  
  def logout
    visit root_path
    click_link 'Logout'
  end

  def signup_with(email, password)
    visit root_path
    click_link 'Sign Up'
    fill_in 'organization[name]', with: 'FooBar'
    fill_in 'organization[email]', with: email
    fill_in 'organization[password]', with: password
    click_button 'Sign Up'
  end
  
end