max_threads_count = 5
min_threads_count = 5
threads min_threads_count, max_threads_count

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Use `workers 0` to disable worker mode.
workers Integer(ENV['WEB_CONCURRENCY'] || 2)

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
preload_app!

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout 3600

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port 3000

# Specifies the `environment` that Puma will run in.
environment "development"

# Specifies the `pidfile` that Puma will use.
pidfile "tmp/pids/server.pid"

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
