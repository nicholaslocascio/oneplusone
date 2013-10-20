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
          team_id = FactoryGirl(:team)
          delete_team(team_id)
          team = Teams.find(team_id)
          expect(team).to eq(nil)
        end

        scenario 'edit a team' do
          login_with organization.email, ''
          team_id = create_team(name)
          name2 = 'Bar Foo'
          team_id = edit_team(name2)
          team = Teams.find(team_id)
          expect(team.name).to eq(name2)
        end
    end