root = "/home/deployer/apps/volontariat/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.volontariat.sock", :backlog => 64
listen 8080, :tcp_nopush => true
worker_processes 2
timeout 30
