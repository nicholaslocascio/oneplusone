class Team < ActiveRecord::Base
  attr_accessible :name
  belongs_to :organization
  has_and_belongs_to_many :people

  validates :name, length: {minimum: 1, maximum: 36}, on: :update
  validates :name, length: {minimum: 1, maximum: 36}, on: :create

  def add_person(person)
    self.people << person
    self.save!
  end

  def remove_person(person)
    self.people.delete(person)
    self.save!
  end

end
