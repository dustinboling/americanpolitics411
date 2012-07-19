namespace :update do

  desc "Update legislation since last update."
  task :legislation => :environment do
    client = Congress::Client.new
    bills = client.bills(:introduced_at => Update.last.suntime)
  end

end
