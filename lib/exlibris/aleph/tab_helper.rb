module Exlibris
  module Aleph
    require 'singleton'
    require 'yaml'
    require 'rails'
    # ==Overview
    # Exlibris::Aleph::TabHelper assumes a mount of Aleph tab files and provides
    # a way to access the various tab settings for patrons, patron_permissions,
    # items, item_permission (both by item status and by item processing status), 
    # collections and pickup locations.
    # It also provides convenience methods for common tasks like getting the 
    # pickup location for a given combination of item status, item process status
    # and borrower status or getting an item's web text.
    # To initialize Exlibris::Aleph::TabHelper call Exlibris::Aleph::TabHelper.init
    # in an initializer.
    class TabHelper
      include Singleton
      attr_reader :updated_at
      @@alephe_tabs = {
        :sub_libraries => :TabSubLibrary
      }
      @@adm_tabs = { 
        :patrons => :PcTabExpFieldExtended, 
        :patron_permissions => :Tab31, 
        :items => :TabWwwItemDesc, 
        :item_permissions_by_item_status => :Tab15ByItemStatus, 
        :item_permissions_by_item_process_status => :Tab15ByItemProcessStatus, 
        :collections => :Tab40, 
        :pickup_locations => :Tab37 }
      @@tabs = @@alephe_tabs.keys + @@adm_tabs.keys
      @@adms = []
      @@tab_path = nil
      @@yml_path = nil
      @@log_path = nil
      @@irrelevant_sub_libraries = ["USR00", "HOME", "BOX", "ILLDT", "NYU51", "ALEPH", "USM50", 
            "MED", "HYL", "HIL", "LAM", "LAW", "LIT", "MUS", "WID", "EXL", "CIRC", "HILR", "HIL01", 
            "HYL01", "HYL02", "HYL03", "HYL04", "HYL05", "HYL06", "LAM01", "LAM02", "LAM03", "LAW01", 
            "LAW02", "LAW03", "LIT01", "LIT02", "MED01", "MED02", "MUS01", "MUS02", "WID01", "WID02", 
            "WID03", "WID04", "WID05", "U60WD", "U60HL", "U60LA", "U70WD", "CBAB", "BCU", "MBAZU", "USM51", 
            "ELEC5", "GDOC5", "EDUC5", "LINC5", "RRLIN", "OU511", "OR512", "OR513", "OR514", "OR515", "U61ED", 
            "U61EL", "U61LN", "S61GD", "USM53", "ELEC7", "GDOC7", "EDUC7", "LINC7", "USM54", "ELEC4", "USM55", 
            "CUN50", "CLEC5", "CDOC5", "CDUC5", "CINC5", "UNI50", "NARCV", "NELEC", "NRLEC", "NGDOC", "NRDOC", 
            "NEDUC", "NHLTH", "NLINC", "NLAW", "NMUSI", "NSCI", "NUPTN"]
      
      # Initialize TabHelper based on path to tabs, path to store yml configs,
      # path for log file, and the ADMs for the Aleph implementation
      #   Exlibris::Aleph::TabHelper.init("/mnt/aleph_tab", ["ADM50", "ADM51"])
      def self.init(tab_path, adms, refresh_time = ->{1.day.ago})
        @@tab_path, @@adms, @@refresh_time = tab_path, adms, refresh_time
        # Set yml path and log path and make directories.
        @@yml_path, @@log_path = File.join(Rails.root, "config/aleph"), File.join(Rails.root, "log")
        Dir.mkdir(@@yml_path) unless @@yml_path.nil? or Dir.exist?(@@yml_path) 
        Dir.mkdir(File.join(@@yml_path, "alephe")) unless @@yml_path.nil? or Dir.exist?(File.join(@@yml_path, "alephe"))
        @@adms.each { |adm| 
          Dir.mkdir(File.join(@@yml_path, adm)) unless @@yml_path.nil? or Dir.exist?(File.join(@@yml_path, adm)) 
        } unless @@adms.nil?
        Dir.mkdir(@@log_path) unless @@log_path.nil? or Dir.exist?(@@log_path)
        # Make readers for each class variable
        class_variables.each do |class_variable|
          define_method "#{class_variable}".sub('@@', '') do
            self.class.class_variable_get "#{class_variable}"
          end 
        end
      end
      
      # Sets class variable of irrelevant sub libraries to be ignored when building sub_libraries YAML
      def self.set_irrelevant_sub_libraries(irrelevant_sub_libraries, replace = true)
        @@irrelevant_sub_libraries |= irrelevant_sub_libraries if replace
        @@irrelevant_sub_libraries = irrelevant_sub_libraries unless replace
      end
      
      # Refreshes the yml files that are used to parse the tables.
      def self.refresh_yml
        @@alephe_tabs.each do |key, klass|
          tab = Exlibris::Aleph::Config.const_get(klass).new(:aleph_library => "ALEPHE", :aleph_mnt_path => @@tab_path).to_h
          File.open( File.join(@@yml_path, "alephe", "#{key}.yml"), 'w' ) { |out| YAML.dump( tab, out ) } unless tab.empty?
        end
        @@adm_tabs.each do |key, klass|
          @@adms.each do |adm|
            tab = Exlibris::Aleph::Config.const_get(klass).new(:aleph_library => adm, :aleph_mnt_path => @@tab_path).to_h
            File.open( File.join(@@yml_path, adm, "#{key}.yml"), 'w' ) { |out| YAML.dump( tab, out ) } unless tab.empty?
          end
        end
      end
      
      # Private initialzize method for the singleton.
      def initialize
        raise ArgumentError.new("No tab path was specified.") if @@tab_path.nil?
        raise ArgumentError.new("No yml path was specified.") if @@yml_path.nil?
        raise ArgumentError.new("No log path was specified.") if @@log_path.nil?
        raise ArgumentError.new("No ADMs were specified.") if @@adms.nil? or @@adms.empty?
        raise ArgumentError.new("No refresh time was specified.") if @@refresh_time.nil?
        self.class.refresh_yml
        @helper_log = Logger.new(File.join(@@log_path, "tab_helper.log"))
        @helper_log.level = Logger::WARN
        @@tabs.each { |tab|
          # Default to empty hash
          instance_variable_set("@#{tab}".to_sym, {})
          # Define reader w/ refresh
          self.class.send(:define_method, tab) {
            return instance_variable_get("@#{tab}".to_sym) unless refresh?
            refresh and return instance_variable_get("@#{tab}".to_sym)
          }
        }
        refresh
      end

      # Returns the sub library display text for the given sub library code
      def sub_library_text(code)
        sub_library = @sub_libraries[code]
        return sub_library[:text] unless sub_library.nil?
      end
  
      # Returns the ADM associated with the given sub library code
      def sub_library_adm(code)
        sub_library = @sub_libraries[code]
        return sub_library[:library] unless sub_library.nil?
      end
  
      # Returns an array of pickup locations based on the given params.
      # Available param keys are:
      #   :adm_library_code, :sub_library_code, :item_status_code,
      #   :item_process_status_code, :bor_status, :availability_status
      def item_pickup_locations(params)
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
  
      # Returns collection text for the given params.
      # Available param keys are:
      #   :adm_library_code, :sub_library_code, :collection_code
      def collection_text(params)
        adm = collections[params[:adm_library_code]]
        sub = adm[params[:sub_library_code]] unless adm.nil?
        coll = sub[params[:collection_code]] unless sub.nil?
        return coll[:text] unless coll.nil?
      end
  
      # Returns web display text for the given params.
      # Available param keys are:
      #   :adm_library_code, :sub_library_code, :item_status_code, :item_process_status_code, :item_status, :item_process_status
      def item_web_text(params)
        adm = items[params[:adm_library_code]]
        item = (adm[params[:item_process_status]].nil?) ? adm[params[:item_status]] : adm[params[:item_process_status]] unless (params[:item_status].nil? and params[:item_process_status].nil?) or adm.nil?
        permissions = item_permissions(params) if item.nil?
        item = adm[permissions[:text]] unless permissions.nil? or adm.nil?
        return item[:web_text] unless item.nil?
        return permissions[:text] unless permissions.nil?
      end
  
      # Returns item permissions for the given params.
      # Available param keys are:
      #   :adm_library_code, :sub_library_code, :item_status_code, :item_process_status_code
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
  
      private
      def refresh?
        return (@updated_at.nil? or @updated_at < @@refresh_time.call)
      end  

      def refresh
        @@alephe_tabs.each_key do |key|
          instance_variable_set("@#{key}".to_sym, YAML.load_file(File.join(@@yml_path, "alephe", "#{key}.yml")))
        end
        @@adm_tabs.each_key do |key|
          @@adms.each do |adm|
            tab = instance_variable_get("@#{key}".to_sym)
            tab[adm] = YAML.load_file(File.join(@@yml_path, adm, "#{key}.yml"))
            instance_variable_set("@#{key}".to_sym, tab)
          end
        end
        # Delete irrelevant sub libraries from @sub_library
        @sub_libraries.delete_if {|key,value| @@irrelevant_sub_libraries.include? key }
        @updated_at = Time.now()
      end

      def raise_required_parameter_error(parameter)
        raise "Initialization error in #{self.class}. Missing required parameter: #{parameter}."
      end
    end
  end
end