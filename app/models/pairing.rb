class Pairing < ActiveRecord::Base
  has_and_belongs_to_many :people
  belongs_to :organization

  def self.make_all_pairings
     organizations = Organization.all
     organizations.each do |org|
       self.make_pairings(org)
     end
  end

  def self.create_pairing(personA,personB,organization,week_number)
      pair = Pairing.new
      pair.people << personA
      pair.people << personB
      pair.week_number = week_number
      organization.pairings << pair
      pair.save!
      return pair
  end


  def self.get_past_relationship_count(personA, personB)
    pairsA = personA.pairings
    pairsB = personB.pairings
    return  (pairsA & pairsB).count
  end

  def self.make_pairings(organization)
    last_pair = organization.pairings.last

    week_number = last_pair ? last_pair.week_number.to_i + 1 : 1

    people = organization.people.all
    teams = organization.teams.all
    people_teammates_hash = self.get_people_teammates_hash(people,teams)
    sorted_people = people.sort_by{|p| people_teammates_hash[p.id].count }

    pairs_to_mail = []

    while sorted_people.count > 1
      person = sorted_people.first
      potentialMatches = []
      people_teammates_hash[person.id].each do |key, value|
        potentialMatches << Person.find(key)
      end
      match = self.best_match(person, potentialMatches, week_number)
      pair = self.create_pairing(person, match, organization, week_number)
      pairs_to_mail << pair

      sorted_people = sorted_people.delete_if {|item| item.id.to_i == match.id.to_i }
      sorted_people.shift

      people_teammates_hash = self.get_people_teammates_hash(sorted_people,teams)
      sorted_people = sorted_people.sort_by{|p| people_teammates_hash[p.id].count }
    end

    puts pairs_to_mail.count.to_s + ' pairs made.'
    puts 'Finished calculating pairs, now sending mail.'
    self.mail_pairs(pairs_to_mail)
  end

  def self.mail_pairs(pairs)
    pairs.each_with_index do |pair, i|
      puts 'mailing ' + (i+1).to_s + " of " + pairs.count.to_s
      puts pair.people.first.name.to_s + ' is paired with ' + pair.people.last.name.to_s
      PairingMailer.mail_pairing(pair).deliver
    end
  end

  def self.get_people_teammates_hash(people,teams)
    hash = Hash.new
    people.each do |person|
        hash[person.id] = Hash.new
    end
    teams.each do |team|
      people.each do |person|
        team.people.each do |team_member|
          hash[person.id][team_member.id] = true if person.id != team_member.id and team_member.in?(people)
        end
      end
    end
    return hash
  end

def self.best_match(person, eligible, week_number)
  past_pairs = person.pairings.where("week_number > ?", (week_number.to_int-5) )
  return eligible.first unless past_pairs.count > 0

  past_relationship_count = Hash.new

  min_count = 9999999
  min_match = eligible.first

  eligible.each do |potential|
    new_count = self.get_past_relationship_count(person,potential)
    if new_count < min_count
      new_count = min_count
      min_match = potential
    end
  end

  return min_match
end

end