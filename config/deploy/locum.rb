role :app, %w(hosting_snayp@calcium.locum.ru)
role :web, %w(hosting_snayp@calcium.locum.ru)
role :db, %w(hosting_snayp@calcium.locum.ru)

set :ssh_options, forward_agent: true
set :rails_env, :production
