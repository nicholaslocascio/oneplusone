  require 'spec_helper'
  require 'organizations_helper'

  feature 'Visitor signs up' do

    scenario 'with valid username/password' do
      signup_with 'valid@example.com', 'password'
      expect(page).to have_content('Logout')
    end

    scenario 'with invalid email' do
      signup_with 'invalid', 'password'
      expect(page).to have_content('Login')
      expect(page).to have_content('Email is invalid')
    end

    scenario 'with blank password' do
      signup_with 'valid@example.com', ''
      expect(page).to have_content('Login')
      expect(page).to have_content("Password digest can't be blank")
    end

    scenario 'with taken email' do
      signup_with 'valid@example.com', 'password'
      logout
      signup_with 'valid@example.com', 'password'
      expect(page).to have_content('Login')
      expect(page).to have_content('Email has already been taken')
    end

  end