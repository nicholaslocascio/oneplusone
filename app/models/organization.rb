class Organization < ActiveRecord::Base
  attr_accessible :email, :password
  has_secure_password

  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_length_of :password, {:within => 4..40}
  validates_presence_of :password
end
