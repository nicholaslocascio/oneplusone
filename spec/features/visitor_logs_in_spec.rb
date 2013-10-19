  require 'spec_helper'
  require 'organizations_helper'

  feature 'Visitor logs in' do

      before do
        signup_with 'valid@example.com', 'password'
        logout
      end

      scenario 'with valid email and password' do
          login_with 'valid@example.com', 'password'
          expect(page).to have_content('Logout')
          expect(page).to have_content('Welcome Back!')
        end

        scenario 'with invalid email' do
          login_with 'invalid_email', 'password'
          expect(page).to have_content('Login')
        end

        scenario 'with blank password' do
          login_with 'valid@example.com', ''
          expect(page).to have_content('Login')
        end
    end