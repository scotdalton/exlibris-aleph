namespace :exlibris do
  namespace :aleph do
    desc "Initialize the Exlibris::Aleph environment"
    task :initialize, :config_file do |task, args|
      # If we're in the Rails environment, use Rails initializers
      if defined?(::Rails) && ::Rails.version >= '3.1.0'
        Rake::Task[:initialize_via_rails_initializers].invoke
      elsif args[:config_file]
        Rake::Task[:initialize_via_config_file].invoke(args)
      elsif args[:tab_path] and args[:adms]
        Rake::Task[:initialize_via_config].invoke(args)
      else
        raise 
      end
    end

    desc "Initialize the Exlibris::Aleph environment via the given yaml config file"
    task :initialize_via_config_file, :config_file do |task, args|
      config_file = args[:config_file]
      # Load Aleph configuration via given config_file
      Exlibris::Aleph.configure do |config|
        config.load_yaml File.expand_path(config_file,  __FILE__)
      end
    end

    desc "Initialize the Exlibris::Aleph environment via the given args"
    task :initialize_via_args, :tab_path, :yaml_path, :adms do |task, args|
      tab_path = args[:tab_path]
      yaml_path = args[:yaml_path]
      adms = args[:adms]
      # Load Aleph configuration via given config_file
      Exlibris::Aleph.configure do |config|
        config.tab_path = tab_path
        config.yaml_path = yaml_path
        config.adms = adms
      end
    end

    desc "Initialize the Exlibris::Aleph environment via the Rails initializers"
    task :initialize_via_rails_initializers do
      Dir.glob("config/initializers/*.rb").each do |initializer|
          require File.expand_path(File.join(Rails.root, initializer), __FILE__)
      end
    end

    desc "Refresh the Exlibris::Aleph tables"
    task :refresh, :config_file, :tab_path, :yaml_path, :adms, :needs => :initialize do
      Exlibris::Aleph::TabHelper.refresh_yml
    end
  end
end