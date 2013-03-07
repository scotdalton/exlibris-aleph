namespace :exlibris do
  namespace :aleph do
    desc "Initialize the Exlibris::Aleph environment"
    task :initialize, :config_file, :tab_path, :yml_path, :adms do |task, args|
      args.with_defaults(:config_file => '', :tab_path => '', :adms => [])
      # If we're in the Rails environment, use Rails initializers
      if defined?(::Rails) && ::Rails.version >= '3.1.0'
        Rake::Task[:environment].invoke
      elsif (not args[:config_file].empty?)
        Rake::Task['exlibris:aleph:initialize_via_config_file'].invoke(args[:config_file])
      elsif (not args[:tab_path].empty?) and (not args[:adms].empty?)
        Rake::Task['exlibris:aleph:initialize_via_args'].invoke(args[:tab_path],  args[:yml_path], args[:adms])
      else
        raise Rake::TaskArgumentError.new("Insufficient arguments.")
      end
      p "Configured tab path: #{Exlibris::Aleph::TabHelper.tab_path}"
      p "Configured yml path: #{Exlibris::Aleph::TabHelper.yml_path}"
      p "Configured ADMs: #{Exlibris::Aleph::TabHelper.adms}"
    end

    desc "Initialize the Exlibris::Aleph environment via the given yaml config file"
    task :initialize_via_config_file, :config_file do |task, args|
      config_file = args[:config_file]
      # Load Aleph configuration via given config_file
      Exlibris::Aleph.configure do |config|
        config.load_yaml config_file
      end
    end

    desc "Initialize the Exlibris::Aleph environment via the given args.\nADMs should be separated by semicolons."
    task :initialize_via_args, :tab_path, :yml_path, :adms do |task, args|
      tab_path = args[:tab_path]
      yml_path = args[:yml_path]
      adms = args[:adms].split(";")
      # Load Aleph configuration via given config_file
      Exlibris::Aleph.configure do |config|
        config.tab_path = tab_path
        config.yml_path = yml_path
        config.adms = adms
      end
    end

    desc "Refresh the Exlibris::Aleph tables"
    task :refresh, [:config_file, :tab_path, :yml_path, :adms] => :initialize do
      Exlibris::Aleph::TabHelper.refresh_yml
    end
  end
end