# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'my-grocery-price-book'
set :repo_url, 'git@bitbucket.org:grantspeelman/grocery-cocktail.git'

set :ssh_options, forward_agent: true

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, '~'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml', 'config/secrets.yml', 'config/newrelic.yml', 'config/public_apis.yml'
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/assets'
)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rack_env, 'production'
set :rails_env, 'production'

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Precompile assets locally and then rsync to deploy server'
  task :compile_assets do
    on roles(:web) do
      rsync_host = host.to_s
      rsync_user = (fetch(:user) || 'gc_user').to_s
      rsync_path = "#{shared_path}/public/assets/"
      run_locally do
        execute 'bundle exec rake assets:precompile'
        execute "rsync -av --delete ./public/assets/ #{rsync_user}@#{rsync_host}:#{rsync_path}"
      end
    end
  end
end

after 'deploy:updated', 'deploy:compile_assets'
