namespace :git_reviewer do
  desc "Sync all the repositories"
  task sync: :environment do
    puts "Start syncing"
    Repository.all.each do |repository|
      puts "[Repository ##{repository.name}] Sync start"
      begin
        repository.sync
        puts "[Repository ##{repository.name}] Sync finished"
      rescue Exception => e
        puts "[Repository ##{repository.name}] Sync failed: #{e.message}"
      end
    end
  end
end
