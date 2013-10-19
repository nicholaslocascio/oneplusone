module OrganizationHelper
  
  def login(a)
    visit root_path
    click_link 'Login'
    fill_in 'email', with: a.email
    fill_in 'password', with: a.password
    click_button 'Login'
  end
  
  def logout(a)
    visit root_path
    click_link 'Logout'
  end
  
end