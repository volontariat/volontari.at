# config valid only for current version of Capistrano
lock '3.4.0'

set :stage, :production
set :rails_env, :production
set :application, 'volontariat'
set :pty, true
#set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :full_app_name, fetch(:application)
set :repo_url, 'git@github.com:volontariat/volontari.at.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH_NAME'] || 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/apps/#{fetch(:application)}"

set :rbenv_type, :system
set :rbenv_ruby, '2.2.0'
set :rbenv_path, '/home/deployer/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
  'config/application.yml', 'config/database.yml', 'config/email.yml', 'config/mongoid.yml', 'config/initializers/airbrake.rb', 
  'config/initializers/recaptcha.rb', 'config/initializers/secret_token.rb', 'config/initializers/lastfm.rb', 
  'config/initializers/musicbrainz.rb', 'config/initializers/message_bus.rb'
)

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, []

set(:config_files, %w(
  nginx.conf
  unicorn_init.sh
  application.yml
  database.yml
  email.yml
  initializers/airbrake.rb
  initializers/recaptcha.rb
  initializers/secret_token.rb
  initializers/lastfm.rb
  initializers/musicbrainz.rb
  initializers/message_bus.rb
))

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:application)}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:application)}"
  }
  #{
  #  source: "log_rotation",
  # link: "/etc/logrotate.d/#{fetch(:full_app_name)}"
  #},
  #{
  #  source: "monit",
  #  link: "/etc/monit/conf.d/#{fetch(:full_app_name)}.conf"
  #}
])

# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  #before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  #after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after 'deploy:publishing', 'deploy:restart'
end