namespace :exlibris do
  namespace :aleph do
    desc "Refresh Aleph YAML Config"
    task :refresh => :initialize do
      Exlibris::Aleph::TabHelper.refresh_yml
    end
  end
end