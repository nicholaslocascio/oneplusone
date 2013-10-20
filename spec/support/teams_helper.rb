module TeamsHelper
  
  def add_team_with(name)
    visit teams_path
    click_button 'Add Team'
    fill_in 'name', with: name
    click_button 'Submit'
  end
  
  def edit_team_with(id)
    visit teams_path
    click_link 'Edit'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Login'
  end

  def delete_team_with(id)
    visit teams_path
    click_button 'Delete'
  end
  
end