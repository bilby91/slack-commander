deploy_path = ENV['DEPLOY_PATH']

timeout 30
worker_processes 1
listen "#{deploy_path}/shared/tmp/sockets/unicorn.sock", backlog: 1024

pid "#{deploy_path}/shared/tmp/pids/unicorn.pid"
stderr_path "#{deploy_path}/shared/log/error.log"
stdout_path "#{deploy_path}/shared/log/production.log"
