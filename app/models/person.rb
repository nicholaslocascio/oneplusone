class Person < ActiveRecord::Base
  attr_accessible :email, :name
  belongs_to :organization
  has_and_belongs_to_many :teams

  validates :name, length: {minimum: 1, maximum: 36}
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
