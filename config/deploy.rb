require "bundler/capistrano"

server "83.133.105.18", :web, :app, :db, primary: true

set :application, "volontariat"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:volontariat/#{application}.git"
set :branch, "master"
set :rake, "#{rake} --trace"
set :bundle_flags, '--deployment'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/application.yml"), "#{shared_path}/config/application.yml"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/email.yml"), "#{shared_path}/config/email.yml"
    put File.read("config/initializers/airbrake.rb"), "#{shared_path}/config/initializers/airbrake.rb"
    put File.read("config/initializers/recaptcha.rb"), "#{shared_path}/config/initializers/recaptcha.rb"
    put File.read("config/initializers/secret_token.rb"), "#{shared_path}/config/initializers/secret_token.rb"
    put File.read("config/initializers/lastfm.rb"), "#{shared_path}/config/initializers/lastfm.rb"
    put File.read("config/initializers/musicbrainz.rb"), "#{shared_path}/config/initializers/musicbrainz.rb"
  end
  
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/email.yml #{release_path}/config/email.yml"
    run "ln -nfs #{shared_path}/config/initializers/airbrake.rb #{release_path}/config/initializers/airbrake.rb"
    run "ln -nfs #{shared_path}/config/initializers/recaptcha.rb #{release_path}/config/initializers/recaptcha.rb"
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    run "ln -nfs #{shared_path}/config/initializers/lastfm.rb #{release_path}/config/initializers/lastfm.rb"
    run "ln -nfs #{shared_path}/config/initializers/musicbrainz.rb #{release_path}/config/initializers/musicbrainz.rb"
  end
  
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  
  before "deploy", "deploy:check_revision"
end

require './config/boot'
require 'airbrake/capistrano'