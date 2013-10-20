require 'spec_helper'

feature 'Reset password' do
  scenario '' do
    organization = FactoryGirl.create(:organization)
    organization.save!
    visit login_path
    click_link 'Forgot Password?'
    fill_in 'email', with:organization.email
    click_button "Reset Password"
    current_path.should eq(root_path)
    expect(page).to have_content "Email sent with password reset instructions"
    organization = Organization.find(organization.id)

    expect(last_email).to be
    expect(last_email.subject).to eq("Password Reset")
    expect(last_email.to).to eq([organization.email])
    expect(last_email.body.encoded).to match(edit_password_reset_url(organization.password_reset_token))
  end
end