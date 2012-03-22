# This guy is a singleton, get one with Exlibris::Aleph::TabHelper.instance
module Exlibris
  module Aleph
    require 'singleton'
    require 'yaml'
    require 'rails'
    class TabHelper
      include Singleton
      attr_reader :sub_libraries, :patrons, :patron_permissions, :items, 
        :item_permissions_by_item_status, :item_permissions_by_item_process_status, 
          :collections, :pickup_locations, :updated_at
      @@adms = []
      @@tab_path = nil
      @@rails_root = (Rails.root.nil?) ? '.' : Rails.root
      @@log_path = @@rails_root + "/log"

      def self.init(tab_path, adms=[])
        @@tab_path = tab_path
        @@adms = adms
        # Make readers for each class variable
        class_variables.each do |class_variable|
          define_method "#{class_variable}".sub('@@', '') do
            self.class.class_variable_get "#{class_variable}"
          end 
        end
      end
      
      def initialize
        raise ArgumentError.new("No tab path was specified.") if @@tab_path.nil?
        raise ArgumentError.new("No ADMs were specified.") if @@adms.empty?
        @helper_log = Logger.new(File.join(@@log_path, "aleph_helper.log"))
        @helper_log.level = Logger::WARN
        @patrons = {}
        @patron_permissions = {}
        @items = {}
        @item_permissions_by_item_status = {}
        @item_permissions_by_item_process_status = {}
        @collections = {}
        @pickup_locations = {}
        @sub_libraries = {}
        refresh
      end
  
      def sub_library_text(params)
        # raise_required_parameter_error :sub_library_code if params[:sub_library_code].nil?
        sub_library = @sub_libraries[params[:sub_library_code]]
        return sub_library[:text] unless sub_library.nil?
      end
  
      def sub_library_adm(params)
        # raise_required_parameter_error :sub_library_code if params[:sub_library_code].nil?
        sub_library = @sub_libraries[params[:sub_library_code]]
        return sub_library[:library] unless sub_library.nil?
      end
  
      def item_pickup_locations(params)
        # raise_required_parameter_error :adm_library_code if params[:adm_library_code].nil?
        # raise_required_parameter_error :sub_library_code if params[:sub_library_code].nil?
        # raise_required_parameter_error :item_status_code if params[:item_status_code].nil?
        # raise_required_parameter_error :item_process_status_code if params[:item_process_status_code].nil?
        # raise_required_parameter_error :bor_status if params[:bor_status].nil?
        # raise_required_parameter_error :availability_status if params[:availability_status].nil?
        adm_locations = pickup_locations[params[:adm_library_code]]
        sub_locations = adm_locations[params[:sub_library_code]] unless adm_locations.nil?

        # First try the most specific
        item_locations = sub_locations[params[:item_status_code]] unless sub_locations.nil?
        item_procesing_locations = item_locations[params[:item_process_status_code]] unless item_locations.nil?
        borrower_locations = item_procesing_locations[params[:bor_status]] unless item_procesing_locations.nil?
        availability_locations = item_procesing_locations[params[:bor_status]] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?
    
        # Wild card item status
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations["##"] unless sub_locations.nil?
        item_procesing_locations = item_locations[params[:item_process_status_code]] unless item_locations.nil?
        borrower_locations = item_procesing_locations[params[:bor_status]] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?

        # Wild card item process status
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations[params[:item_status_code]] unless sub_locations.nil?
        item_procesing_locations = item_locations["##"] unless item_locations.nil?
        borrower_locations = item_procesing_locations[params[:bor_status]] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?

        # Wild card item status and item process status
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations["##"] unless sub_locations.nil?
        item_procesing_locations = item_locations["##"] unless item_locations.nil?
        borrower_locations = item_procesing_locations[params[:bor_status]] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?

        # Wild card patron status
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations[params[:item_status_code]] unless sub_locations.nil?
        item_procesing_locations = item_locations[params[:item_process_status_code]] unless item_locations.nil?
        borrower_locations = item_procesing_locations["##"] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?

        # Wild card patron status and item status
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations["##"] unless sub_locations.nil?
        item_procesing_locations = item_locations[params[:item_process_status_code]] unless item_locations.nil?
        borrower_locations = item_procesing_locations["##"] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?

        # Wild card patron status and item process status
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations[params[:item_status_code]] unless sub_locations.nil?
        item_procesing_locations = item_locations["##"] unless item_locations.nil?
        borrower_locations = item_procesing_locations["##"] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?

        # Wild card everything
        item_locations, item_procesing_locations, borrower_locations = nil, nil, nil
        item_locations = sub_locations["##"] unless sub_locations.nil?
        item_procesing_locations = item_locations["##"] unless item_locations.nil?
        borrower_locations = item_procesing_locations["##"] unless item_procesing_locations.nil?
        locations = (borrower_locations.has_key?(params[:availability_status])) ? 
          borrower_locations[:availability_status] : borrower_locations["#"] unless borrower_locations.nil?
        return locations[:pickup_locations] unless locations.nil?
    
        # Set the pickup location to default to the passed in sub library
        @helper_log.warn(
            "Warning in #{self.class}. "+
            "Pickup locations not found. "+
            "Defaulting to Aleph item sub library, #{params[:sub_library_code]}.\n"+
            "Additional parameters:\n"+ 
            "\tADM library: #{params[:adm_library_code]}\n"+
            "\tSub library: #{params[:sub_library_code]}\n"+
            "\tItem status: #{params[:item_status_code]}\n"+
            "\tItem process status: #{params[:item_process_status_code]}\n"+
            "\tAvailability status: #{params[:availability_status]}\n"+
            "\tBorrower status: #{params[:bor_status]}\n"
          )
          return [params[:sub_library_code]]
      end
  
      def collection_text(params)
        # raise_required_parameter_error :adm_library_code if params[:adm_library_code].nil?
        # raise_required_parameter_error :sub_library_code if params[:sub_library_code].nil?
        # raise_required_parameter_error :collection_code if params[:collection_code].nil?
        adm = collections[params[:adm_library_code]]
        sub = adm[params[:sub_library_code]] unless adm.nil?
        coll = sub[params[:collection_code]] unless sub.nil?
        return coll[:text] unless coll.nil?
      end
  
      def item_web_text(params)
        adm = items[params[:adm_library_code]]
        item = (adm[params[:item_process_status]].nil?) ? adm[params[:item_status]] : adm[params[:item_process_status]] unless (params[:item_status].nil? and params[:item_process_status]) or adm.nil?
        permissions = item_permissions(params) if item.nil?
        item = adm[permissions[:text]] unless permissions.nil? or adm.nil?
        return item[:web_text] unless item.nil?
        return permissions[:text] unless permissions.nil?
      end
  
      def item_permissions(params)
        unless params[:item_process_status_code].nil?
          adm_permissions = 
            item_permissions_by_item_process_status[params[:adm_library_code]]
          sublibrary_permissions = 
            adm_permissions[params[:sub_library_code]] unless adm_permissions.nil?
          item_process_status_permissions = 
            sublibrary_permissions[params[:item_process_status_code]] unless sublibrary_permissions.nil?
          return item_process_status_permissions unless item_process_status_permissions.nil?
        end
        unless params[:item_status_code].nil?
          adm_permissions = item_permissions_by_item_status[params[:adm_library_code]]
          sublibrary_permissions = 
            adm_permissions[params[:sub_library_code]] unless adm_permissions.nil?
          item_status_permissions = 
            sublibrary_permissions[params[:item_status_code]] unless sublibrary_permissions.nil?
          return item_status_permissions unless item_status_permissions.nil?
        end
        @helper_log.warn(
            "Warning in #{self.class}. "+
            "Item permissions not found. "+
            "Additional parameters:\n"+ 
            "\tADM library: #{params[:adm_library_code]}\n"+
            "\tSub library: #{params[:sub_library_code]}\n"+
            "\tItem status: #{params[:item_status_code]}\n"+
            "\tItem process status: #{params[:item_process_status_code]}"
          )
        return {}
      end
  
      def refresh
        @updated_at = Time.now()
        @sub_libraries = 
          Exlibris::Aleph::Config::TabSubLibrary.new({
            :aleph_library => "ALEPHE", :aleph_mnt_path => @@tab_path}).to_h
        @@adms.each do |adm|
          @patrons[adm] = 
            Exlibris::Aleph::Config::PcTabExpFieldExtended.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
          @patron_permissions[adm] = 
            Exlibris::Aleph::Config::Tab31.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
          @items[adm] = 
            Exlibris::Aleph::Config::TabWwwItemDesc.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
          @item_permissions_by_item_status[adm] = 
            Exlibris::Aleph::Config::Tab15ByItemStatus.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
          @item_permissions_by_item_process_status[adm] = 
            Exlibris::Aleph::Config::Tab15ByItemProcessStatus.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
          @collections[adm] = 
            Exlibris::Aleph::Config::Tab40.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
          @pickup_locations[adm] = 
            Exlibris::Aleph::Config::Tab37.new({
              :aleph_library => adm, :aleph_mnt_path => @@tab_path}).to_h
        end
      end

      private
      def raise_required_parameter_error(parameter)
        raise "Initialization error in #{self.class}. Missing required parameter: #{parameter}."
      end
    end
  end
end