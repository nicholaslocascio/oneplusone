# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

org = Organization.create!(:email => 'gibbons@initech.com',:name=> 'Initech', :password=> 'tpsreports1999')

15.times do
  t = Team.create!(:name=> Faker::Company.name)
  org.teams << t
  org.save!
end

90.times do |i|
  p = Person.create!(:email => Faker::Internet.email + i.to_s, :name=> Faker::Name.first_name + ' ' + Faker::Name.last_name)
  rand(5).times do |j|
    team = org.teams.first(:offset => rand(org.teams.count))
    unless p.team_ids.include?(team.id)
      org.people << p
      team.add_person(p)
    end
  end
  org.save!
end
