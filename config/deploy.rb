set :application, "shortener_service"
set :repo_url, "git@github.com:ngghai99/shortener_service.git"

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
set :linked_files, %w[config/credentials.yml.enc config/master.key config/.env]
set :rails_env, 'production'
set :rbenv_ruby, "3.1.4"

before 'deploy:starting', 'config_files:upload'
set :keep_releases, 5

