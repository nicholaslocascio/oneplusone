  require 'spec_helper'
  require 'organizations_helper'

  feature 'Visitor logs in' do

      let(:organization) { FactoryGirl.create(:organization) }
      let(:organization2) { FactoryGirl.create(:organization) }

      scenario 'with valid email and password' do
          login_with organization.email, organization.password
          expect(page).to have_content('Logout')
          expect(page).to have_content('Welcome Back!')
        end

        scenario 'with invalid email' do
          login_with 'invalid_email', 'password'
          expect(current_path).to eq(login_path)
        end

        scenario 'with blank password' do
          login_with organization.email, ''
          expect(current_path).to eq(login_path)
        end
    end