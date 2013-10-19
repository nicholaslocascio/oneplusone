  require 'spec_helper'
  require 'organizations_helper'

  feature 'Organization Auth', %q{
    An Organization should be Authorized to its edit/update
    actions, but not other organization's edit/update actions.
  } do

    before do
      @organization = FactoryGirl.create(:organization)
    end

    scenario 'organization accessing own edit/update' do
      login_with(@organization.email,@organization.password)
      visit edit_organization_path(@organization)
    end

    scenario 'visitor accessing edit/update' do
      visit edit_organization_path(@organization)
      expect(page).to have_content "Not Authorized"
    end

    scenario 'organization accessing anothers edit/update' do
      @organization2 = FactoryGirl.create(:organization)
      login_with(@organization2.email,@organization2.password)
      visit edit_organization_path(@organization)
      expect(page).to have_content "Not Authorized"
    end

  end