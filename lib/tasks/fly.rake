namespace :fly do
  task :build => 'assets:precompile'

  task :release => 'db:migrate'

  task :server do
    sh 'bin/rails server'
  end
end