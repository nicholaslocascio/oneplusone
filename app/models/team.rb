class Team < ActiveRecord::Base
  attr_accessible :name
  belongs_to :organization

  validates :name, length: {minimum: 1, maximum: 36}, on: :update
  validates :name, length: {minimum: 1, maximum: 36}, on: :create

end
