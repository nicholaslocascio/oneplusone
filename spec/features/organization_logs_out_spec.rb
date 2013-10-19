  require 'spec_helper'
  require 'organizations_helper'

  feature 'Organization can log out', %q{
    Organizations should be able to log out.
  } do

    before do
      @organization = FactoryGirl.create(:organization)
    end

    scenario 'Organization currently logged in' do
      login_with(@organization.email,@organization.password)
      logout
      expect(page).to have_content "Login"
    end

  end