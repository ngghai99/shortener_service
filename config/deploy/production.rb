server '146.190.107.33', user: 'deploy', roles: %w{app db web}
set :stage, :production
set :rails_env, :production
