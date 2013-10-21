desc "This task is called by the Heroku scheduler add-on"
task :make_all_pairings => :environment do
  puts "Make pairings"
  Pairing.make_all_pairings
  puts "done."
end