module Exlibris
  module Aleph
    
    #
    # Specify global configuration settings for
    #
    module Config
      class << self
        include WriteAttributes
        attr_accessor :base_url, :rest_url, :adms, :refresh_time, :tab_path, 
          :yml_path, :logger, :irrelevant_sub_libraries, :load_time

        def load_yaml file
          write_attributes YAML.load_file(file)
          self.load_time = Time.now
        end
      end

      #
      # These attributes default to the global config settings if not 
      # specified locally.
      #
      module Attributes
        def config
          @config ||= Config
        end

        # Aleph base url
        def base_url
          @base_url ||= String.new config.base_url.to_s
        end

        # Aleph rest url
        def rest_url
          @rest_url ||= (String.new(config.rest_url.to_s) || "#{base_url}:1891/rest-dlf")
        end

        # Refresh time for TabHelper
        def refresh_time
          @refresh_time ||= (config.refresh_time) ? config.refresh_time : lambda{1.day.ago}
        end

        # Aleph ADMs to parse
        def adms
          @adms ||= (config.adms) ? config.adms.collect{|adm| adm.downcase} : []
        end

        # Tab path for Aleph tables
        def tab_path
          @tab_path ||= File.join(config.tab_path)
        end

        # YAML path for persisting Aleph config
        def yml_path
          @yml_path ||= (File.join(config.yml_path) || File.join(tab_path, "..", "config", "aleph"))
        end

        def logger
          @logger ||= (config.logger) ? config.logger : Logger.new(File.join(yml_path, "..", "..", "log", "exlibris_aleph.log"))
        end

        def irrelevant_sub_libraries
          @irrelevant_sub_libraries ||= 
            (config.irrelevant_sub_libraries) ? config.irrelevant_sub_libraries : 
              [ "USR00", "HOME", "BOX", "ILLDT", "NYU51", "ALEPH", "USM50",
                "MED", "HYL", "HIL", "LAM", "LAW", "LIT", "MUS", "WID", "EXL", "CIRC", "HILR", "HIL01",
                "HYL01", "HYL02", "HYL03", "HYL04", "HYL05", "HYL06", "LAM01", "LAM02", "LAM03", "LAW01",
                "LAW02", "LAW03", "LIT01", "LIT02", "MED01", "MED02", "MUS01", "MUS02", "WID01", "WID02",
                "WID03", "WID04", "WID05", "U60WD", "U60HL", "U60LA", "U70WD", "CBAB", "BCU", "MBAZU", "USM51",
                "ELEC5", "GDOC5", "EDUC5", "LINC5", "RRLIN", "OU511", "OR512", "OR513", "OR514", "OR515", "U61ED",
                "U61EL", "U61LN", "S61GD", "USM53", "ELEC7", "GDOC7", "EDUC7", "LINC7", "USM54", "ELEC4", "USM55",
                "CUN50", "CLEC5", "CDOC5", "CDUC5", "CINC5", "UNI50", "NARCV", "NELEC", "NRLEC", "NGDOC", "NRDOC",
                "NEDUC", "NHLTH", "NLINC", "NLAW", "NMUSI", "NSCI", "NUPTN" ]
        end
      end
    end
  end
end