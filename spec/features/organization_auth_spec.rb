  require 'spec_helper'
  require 'organizations_helper'

  feature 'Organization Auth', %q{
    Organizations should be able to be created, logged in to,
    logged out from. An Organization should be Authorized to its edit/update
    actions, but not other organization's edit/update actions.
  } do

      before do
        @organization = FactoryGirl.create(:organization)
      end

    scenario 'Organization sign up' do
      visit root_path
      click_link 'Sign Up'
      fill_in 'organization[email]', with: 'organization@example.com'
      fill_in 'organization[password]', with: 'newpassword'
      click_button 'Sign Up'
      expect(page).to have_content "Organization is now on 1+1!"
    end

    scenario 'Organization log in' do
      login(@organization)
      expect(page).to have_content "Welcome Back!"
    end

    scenario 'Organization log out' do
      login(@organization)
      logout(@organization)
      expect(page).to have_content "Logged out"
    end

    scenario 'Organizations have access to their edit/update actions.' do
      login(@organization)
      visit edit_organization_path(@organization)
    end

    # scenario 'Visitors dont have access to Organization edit/update actions.' do
    #   login(@organization)
    #   logout(@organization)
    #   visit edit_organization_path(@organization)
    #   expect(page).to have_content "Not Authorized"
    # end

    scenario 'Other Organizations dont have access to other Organizations edit/update actions.' do
      @organization2 = FactoryGirl.create(:organization)
      login(@organization2)
      visit edit_organization_path(@organization)
      expect(page).to have_content "Not Authorized"
    end

  end