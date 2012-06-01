namespace :git_reviewer do
  desc "Sync all the repositories"
  task sync: :environment do
    puts "Start syncing"
    Repository.all.each do |repository|
      puts "[Repository ##{repository.name}] Sync start"
      repository.sync
      puts "[Repository ##{repository.name}] Sync finished"
    end
  end
end
