require "bundler/capistrano"

set :application, "git_reviewer"
set :user, "rjk"

set :use_sudo, false

set :deploy_to, "~/#{application}"
set :repository,  "git@github.com:clubsite/git_reviewer.git"
set :scm, :git
default_run_options[:pty] = true
set :keep_releases, 5
set :deploy_via, :remote_cache

role :web, "reviews.creativecode.nl"                   
role :app, "reviews.creativecode.nl"                   
role :db,  "reviews.creativecode.nl", :primary => true 

after "deploy:restart", "deploy:cleanup"
after "deploy:create_symlink", "deploy:create_symlink_repos"

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   task :create_symlink_repos do
      run "mkdir -p #{shared_path}/repos && ln -nfs #{shared_path}/repos #{current_path}/repos"
   end
end

namespace :repo do
  task :sync, :roles => :app do
    run "cd #{latest_release} && #{rake} RAILS_ENV=production git_reviewer:sync"
  end
end