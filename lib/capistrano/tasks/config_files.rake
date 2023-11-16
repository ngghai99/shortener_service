namespace :config_files do
  desc 'Upload yml files inside config folder'
  task :upload do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"

      upload! StringIO.new(File.read('config/credentials.yml.enc')), "#{shared_path}/config/credentials.yml.enc"
      upload! StringIO.new(File.read('config/master.key')), "#{shared_path}/config/master.key"
    end
  end
end
