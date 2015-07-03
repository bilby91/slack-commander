require 'dotenv'
Dotenv.load

deploy_path = ENV['DEPLOY_PATH']

timeout 30
worker_processes 1
listen "#{deploy_path}/current/tmp/sockets/unicorn.sock", backlog: 1024

pid "#{deploy_path}/current/tmp/pids/unicorn.pid"
stderr_path "#{deploy_path}/current/log/error.log"
stdout_path "#{deploy_path}/current/log/production.log"
