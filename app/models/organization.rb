class Organization < ActiveRecord::Base
  attr_accessible :email, :password, :name

  has_secure_password


  validates :name, length: {minimum: 1, maximum: 36}, on: :update, allow_nil: true
  validates :name, length: {minimum: 1, maximum: 36}, on: :create

  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_nil: true

  has_many :teams

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