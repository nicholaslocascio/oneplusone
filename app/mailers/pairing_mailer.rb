class PairingMailer < ActionMailer::Base

  default from: '1plus1@gmail.com'

  def mail_pairing(pairing)
    @personA = pairing.people.first
    @personB = pairing.people.last
    mail(to: @personA.email, subject: "This Week's Pairing")
    mail(to: @personA.email, subject: "This Week's Pairing")
  end
end