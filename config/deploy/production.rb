set :user, ENV['DEPLOY_USER']

set :use_sudo, false

set :ssh_options, port: 22, forward_agent: true

set :nginx_domains, ENV['NGINX_DOMAIN']

server ENV['HOST_URL'], user: fetch(:user), roles: %w(web app db)
