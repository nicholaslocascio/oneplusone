# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

org = Organization.create!(:email => 'gibbons@initech.com',:name=> 'Initech', :password=> 'tpsreports1999')

12.times do
  t = Team.create!(:name=> Faker::Company.name)
  org.teams << t
  org.save!
end

90.times do |i|
  p = Person.create!(:email => Faker::Internet.email + i.to_s, :name=> Faker::Name.first_name + ' ' + Faker::Name.last_name)
  team = org.teams.first(:offset => rand(org.teams.count))
  org.people << p
  org.save!
 team.add_person(p)
end
