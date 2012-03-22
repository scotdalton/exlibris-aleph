# desc "Explaining what the task does"
# task :exlibris:aleph do
#   # Task goes here
# end
namespace :exlibris do
  namespace :aleph do

    desc "Refresh Aleph YAML Config"
    task :refresh_config, [:aleph_mnt_path] => :environment do |t, args|
      args.with_defaults(:aleph_mnt_path => "/mnt/aleph_tab")
      require "yaml"
      tab_sub_library = Exlibris::Aleph::Config::TabSubLibrary.new({
          :aleph_library => "ALEPHE", :aleph_mnt_path => args[:aleph_mnt_path]})
      file = File.join(Rails.root, "config", "aleph", "sub_libraries.yaml")
      File.open( file, 'w' ) { |out| YAML.dump( tab_sub_library.to_h, out ) } unless tab_sub_library.to_h.empty?
    
      Exlibris::Aleph::Config::Helper.class_variable_get(:@@adms).each do |adm|
        tab40 = Exlibris::Aleph::Config::Tab40.new({
            :aleph_library => adm, :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "collections.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab40.to_h, out ) } unless tab40.to_h.empty?
    
        tab40 = Exlibris::Aleph::Config::Tab40.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "collections.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab40.to_h, out ) } unless tab40.to_h.empty?
    
        tab15 = Exlibris::Aleph::Config::Tab15ByItemStatus.new({
            :aleph_library => "NYU50", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "item_permissions_by_item_status.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab15.to_h, out ) } unless tab15.to_h.empty?
    
        tab15 = Exlibris::Aleph::Config::Tab15ByItemProcessStatus.new({
            :aleph_library => "NYU50", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "item_permissions_by_item_process_status.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab15.to_h, out ) } unless tab15.to_h.empty?
    
        tab15 = Exlibris::Aleph::Config::Tab15ByItemStatus.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "item_permissions_by_item_status.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab15.to_h, out ) } unless tab15.to_h.empty?
    
        tab15 = Exlibris::Aleph::Config::Tab15ByItemProcessStatus.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "item_permissions_by_item_process_status.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab15.to_h, out ) } unless tab15.to_h.empty?
    
        tab_www = Exlibris::Aleph::Config::TabWwwItemDesc.new({
            :aleph_library => "NYU50", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "item_mappings.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab_www.to_h, out ) } unless tab_www.to_h.empty?
    
        tab_www = Exlibris::Aleph::Config::TabWwwItemDesc.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "item_mappings.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab_www.to_h, out ) } unless tab_www.to_h.empty?
    
        tab31 = Exlibris::Aleph::Config::Tab31.new({
            :aleph_library => "NYU50", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "patron_permissions.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab31.to_h, out ) } unless tab31.to_h.empty?
    
        tab31 = Exlibris::Aleph::Config::Tab31.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "patron_permissions.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab31.to_h, out ) } unless tab31.to_h.empty?
    
        tab37 = Exlibris::Aleph::Config::Tab37.new({
            :aleph_library => "NYU50", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "pickup_locations.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab37.to_h, out ) } unless tab37.to_h.empty?
    
        tab37 = Exlibris::Aleph::Config::Tab37.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "pickup_locations.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab37.to_h, out ) } unless tab37.to_h.empty?
    
        tab_pc_tab_etc = Exlibris::Aleph::Config::PcTabExpFieldExtended.new({
            :aleph_library => "NYU50", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu50", "patron_mappings.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab_pc_tab_etc.to_h, out ) } unless tab_pc_tab_etc.to_h.empty?
    
        tab_pc_tab_etc = Exlibris::Aleph::Config::PcTabExpFieldExtended.new({
            :aleph_library => "NYU51", :aleph_mnt_path => args[:aleph_mnt_path]})
        file = File.join(Rails.root, "config", "aleph", "nyu51", "patron_mappings.yaml")
        File.open( file, 'w' ) { |out| YAML.dump( tab_pc_tab_etc.to_h, out ) } unless tab_pc_tab_etc.to_h.empty?
      end
    end
  end
emd