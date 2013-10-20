module TeamsHelper
  
  def add_team_with(name)
    visit teams_path
    click_button 'Add Team'
    fill_in 'name', with: name
    click_button 'Submit'
  end
  
  def edit_team_name(id, newName)
    visit teams_path
    click_link edit_teams_url(id)
    fill_in 'name', with: newName
    click_button 'Submit'
  end

  # def edit_team_membership(teamId, memberId)
  #   visit teams_path
  #   click_link edit_teams_url(id)
  # end

  def delete_team_with(id)
    visit teams_path
    click_button 'Delete'
    click_button 'OK'
  end
  
end