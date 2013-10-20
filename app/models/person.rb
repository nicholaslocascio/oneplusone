class Person < ActiveRecord::Base
  attr_accessible :email, :name

  belongs_to :organization
  has_and_belongs_to_many :teams

end
