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
after "deploy:symlink", "deploy:symlink_repos"

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   task :symlink_repos do
      run "mkdir -p #{shared_path}/repos && ln -nfs #{shared_path}/repos #{current_path}/repos"
   end
end