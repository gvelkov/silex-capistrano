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

namespace :myproject do

    task :vendors :do
        run "curl -s http://getcomposer.org/installer | php --install-dir=#{release_path}"
        run "#{release_path}/composer.phar install"
    end

    task :uploads do
        run "mkdir -p #{shared_path}/web/uploads"
        run "chmod -R 775 #{shared_path}/web/uploads"
        run "ln -nfs #{shared_path}/web/uploads #{release_path}/web/uploads"
    end

    task :disable do
        run "echo 'Site is on maintenance right now. Sorry.' > #{shared_path}/web/maintenance.html"
        run "cp #{shared_path}/web/maintenance.html #{latest_release}/web/maintenance.html"
    end

    task :enable do
        run "rm -f #{latest_release}/web/maintenance.html"
    end

end

after "deploy:update_code", "myproject:disable"
after "deploy:symlink", "myproject:uploads", "myproject:enable"