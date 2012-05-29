set :application, "silex-capistrano"
set :deploy_to, "/var/www/#{application}"
default_run_options[:pty] = true

set :scm, :git
set :repository,  "git@github.com:memphys/silex-capistrano.git"
set :deploy_via, :remote_cache
set :branch, "master"
set :keep_releases, 3

server "107.22.224.149", :app, :web, :db, :primary => true
set :ssh_options, {:forward_agent => true, :port => 22}
set :user, "deployer"
set :use_sudo, false

namespace :deploy do

    task :start do
    end

    task :stop do
    end

    task :migrate do
    end

    task :restart do
    end

end
