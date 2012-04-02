namespace :exlibris do
  namespace :aleph do
    desc "Refresh Aleph YAML Config"
    task :refresh do
      require 'rails'
      require File.join(Rails.root, "config/environment.rb")
      Exlibris::Aleph::TabHelper.refresh_yml
    end
  end
end