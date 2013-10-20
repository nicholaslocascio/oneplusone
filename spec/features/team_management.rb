  require 'spec_helper'
  require 'organizations_helper'

  feature 'Organization wants to ' do

      let(:organization) { FactoryGirl.create(:organization) }
      let(:name) { 'Foo Bar' }

      scenario 'create a team' do
          login_with organization.email, organization.password
          create_team(name)
          expect(page).to have_content(name + ' created')
        end

        scenario 'delete a team' do
          login_with organization.email, organization.password
          team_id = create_team(name)
          delete_team(team_id)
          expect(current_path).to eq(login_path)
        end

        scenario 'edit a team' do
          login_with organization.email, ''
          team_id = create_team(name)
          expect(current_path).to eq(login_path)
        end
    end