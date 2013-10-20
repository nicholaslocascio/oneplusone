  require 'spec_helper'
  require 'organizations_helper'

  feature 'Visitor signs up' do

  let(:email1) {"user_#{rand(1000).to_s}@factory.com"}

    scenario 'with valid username/password' do
      signup_with email1, 'valid'
      expect(page).to have_content('Logout')
    end

    scenario 'with invalid email' do
      signup_with 'invalid_email', 'valid'
      expect(page).to have_content('Login')
      expect(page).to have_content('Email is invalid')
    end

    scenario 'with blank password' do
      signup_with email1, ''
      expect(page).to have_content('Login')
      expect(page).to have_content("Password digest can't be blank")
    end

    scenario 'with taken email' do
      signup_with email1, 'valid'
      logout
      signup_with email1, 'validd'
      expect(page).to have_content('Login')
      expect(page).to have_content('Email has already been taken')
    end
    
  end