namespace :exlibris do
  namespace :aleph do
    desc "Refresh Aleph YAML Config"
    task :refresh => :initialize do
      Exlibris::Aleph::TabHelper.refresh_yml
    end
    
    task :initialize do
      Dir.glob("config/initializers/*.rb").each do |initializer|
          require initializer
      end
    end
  end
end