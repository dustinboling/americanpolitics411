namespace :destroy do
  desc "Destroy all PersonVotes"
  task :votes => :environment do
    count = PersonVote.count
    puts "Deleting #{count} PersonVote's..."
    PersonVote.find_each(&:destroy)
    puts "Success."
  end

  desc "Destroy all legislation"
  task :legislation => :environment do
    count = Legislation.count
    puts "Deleting #{count} Legislation records...\n"
    Legislation.find_each(&:destroy)
    puts "Success."
  end

end
