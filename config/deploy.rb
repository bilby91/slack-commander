# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'slack-commander'
set :repo_url, ENV['REPO_URL']


# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, ENV['DEPLOY_PATH']

set :keep_releases, 10

set :temp_dir, '/tmp'

set :linked_files, %W(.env)
set :linked_dirs, %w(tmp/pids tmp/sockets log)

set :file_uploads, [
  {
    origin: '.env',
    destination: '.env'
  },
  {
    origin: 'config/heaven.yml',
    destination: 'config/heaven.yml'
  }
]

set :shared_folders, %w(config)

set :symlinks, [
  {
    source: 'nginx.conf',
    link: "/etc/nginx/sites-enabled/#{fetch(:application)}"
  }
]

# Nginx upstream
set :app_server_socket, "#{shared_path}/tmp/sockets/unicorn.sock"

set :unicorn_conf, "#{current_path}/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do

  task :restart do
    on roles(:app) do
      execute "if [ -f #{fetch(:unicorn_pid)} ]; then kill -USR2 `cat #{fetch(:unicorn_pid)}`; else cd #{current_path} && bundle exec unicorn -c #{fetch(:unicorn_conf)} -D; fi"
    end
  end

  task :start do
    on roles(:app) do
      within current_path do
        execute :bundle, "exec unicorn", "-c", fetch(:unicorn_conf), "-D"
      end
    end
  end

  task :stop do
    on roles(:app) do
      execute "if [ -f #{fetch(:unicorn_pid)} ]; then kill -QUIT `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end

end
