class OrganizationMailer < ActionMailer::Base

  default from: '1plus1@gmail.com'

  def password_reset(organization)
    @organization = organization
    mail(to: @organization.email, subject: 'Password Reset')
  end
end