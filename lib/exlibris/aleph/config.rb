module Exlibris
  module Aleph
    #
    # Global configuration settings for Exlibris::Aleph
    #
    module Config
      class << self
        attr_accessor :base_url, :rest_url, :adms, :table_path,
          :irrelevant_sub_libraries

        def rest_url
          @rest_url ||= "#{base_url}:1891"
        end

        def adms
          @adms ||= []
        end

        def admin_libraries
          @admin_libraries ||= adms.map { |code| AdminLibrary.new(code) }
        end

        def irrelevant_sub_libraries
          @irrelevant_sub_libraries ||= %w{
            USR00 HOME BOX ILLDT NYU51 ALEPH USM50 MED HYL HIL LAM LAW LIT MUS
            WID EXL CIRC HILR HIL01 HYL01 HYL02 HYL03 HYL04 HYL05 HYL06 LAM01
            LAM02 LAM03 LAW01 LAW02 LAW03 LIT01 LIT02 MED01 MED02 MUS01 MUS02
            WID01 WID02 WID03 WID04 WID05 U60WD U60HL U60LA U70WD CBAB BCU 
            MBAZU USM51 ELEC5 GDOC5 EDUC5 LINC5 RRLIN OU511 OR512 OR513 OR514
            OR515 U61ED U61EL U61LN S61GD USM53 ELEC7 GDOC7 EDUC7 LINC7 USM54
            ELEC4 USM55 CUN50 CLEC5 CDOC5 CDUC5 CINC5 UNI50 NARCV NELEC NRLEC
            NGDOC NRDOC NEDUC NHLTH NLINC NLAW NMUSI NSCI NUPTN
          }
        end
      end
    end
  end
end