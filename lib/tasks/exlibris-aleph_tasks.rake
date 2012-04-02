namespace :exlibris do
  namespace :aleph do
    desc "Initialize rake environment"
    task :initialize do
      Dir.glob("config/initializers/*.rb").each do |initializer|
          require File.expand_path(initializer, __FILE__)
      end
    end

    desc "Refresh Aleph YAML Config"
    task :refresh => :initialize do
      Exlibris::Aleph::TabHelper.refresh_yml
    end
  end
end