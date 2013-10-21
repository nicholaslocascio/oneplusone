class Pairing < ActiveRecord::Base
  has_and_belongs_to_many :people

  def self.make_all_pairings
    # organizations = Organization.all
    # organizations.each do |org|
    #   self.make_pairings(org)
    # end
    self.make_pairings(Organization.last)
  end

  def self.make_pairings(organization)
    last_pair = organization.pairings.last
    if last_pair
      week_number = organization.pairings.last.week_number
    else
      week_number = 1
    end

    people = organization.people.all
    puts people.count.to_s
    teams = organization.teams.all
    people_teammates_hash = self.get_people_teammates_hash(people,teams)
    puts people_teammates_hash.to_s

    puts people.to_s
    sorted_people = people.sort_by{|p| people_teammates_hash[p.id].count }
    puts sorted_people.to_s

    sorted_people.each do |person|
      match = self.best_match(person, people_teammates_hash[person.id], week_number)
      pair = Pairing.new
      pair << person
      pair << match
      weeks.pairs << pair
      org.pairs << pair
      pair.save!
    end
  end

  def self.get_people_teammates_hash(people,teams)
    hash = Hash.new
    people.each do |person|
        hash[person.id] = Hash.new
    end
    teams.each do |team|
      people.each do |person|
        people.each do |team_member|
          hash[person.id][team_member.id] = true unless person.id == team_member.id
        end
      end
    end
    return hash
  end

def self.best_match(person,eligible,week_number)
  past_pairs = person.pairing.where("week_number > ", week_number-5)
  return eligible unless past_pairs.count > 0

  past_pairings_count = Hash.new
  eligible.each do |person|
      past_pairings_count[person.id] = 0
  end

  past_5_weeks.each do |week|
    week.pairs.each do | pair, i|
      personA = pair.people.first
      personB = pair.people.last 
      if personA in past_pairings_count and personB in past_pairings_count
        other_id = pair.people.first.id == person.id? pair.people.last.id : pair.people.first.id
      end
    end
  end
end

  def self.get_past_pairings_count(people,teams)
    hash = Hash.new
    people.each do |person|
        hash[person.id] = Hash.new
    end
    teams.each do |team|
      people.each do |person|
        people.each do |team_member|
          hash[person.id][team_member.id] = true unless person.id == team_member.id
        end
      end
    end
    return hash
  end
end