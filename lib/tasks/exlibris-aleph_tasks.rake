# desc "Explaining what the task does"
# task :exlibris:aleph do
#   # Task goes here
# end
namespace :exlibris do
  namespace :aleph do
    desc "Refresh Aleph YAML Config"
    task :refresh, [:aleph_mnt_path] => :environment do |t, args|
      Exlibris::Aleph::TabHelper.refresh_yml
    end
  end
emd