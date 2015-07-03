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
