class Organization < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  has_secure_password

  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true


  def send_password_reset
    self.password_reset_token = generate_token
    self.password_reset_sent_at = Time.zone.now
    self.save!
    OrganizationMailer.password_reset(self).deliver
  end

  def generate_token
    SecureRandom.urlsafe_base64.to_s
  end

end