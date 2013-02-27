module Exlibris
  module Aleph
    module TabParser
      class Tab15ByItemStatus < Exlibris::Aleph::TabParser::SubLibrary

        def initialize(args)
          args[:aleph_file_name] = "tab15.eng"
          args[:pattern] = /^(.{5})\s([0-9#]{2})\s([A-Z#]{2})\s(L)\s(.{30})\s([YN])\s([YN])\s([YNCT])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YNC])\s([AOC])/
          args[:pattern_key] = {
            1  => :sub_library, 
            2  => :item_status, 
            3  => :item_process_status, 
            5  => :text, 
            6  => :loan,
            7  => :renew,
            8  => :hold_request,
            9  => :photocopy_request,
            10 => :web_opac,
            11 => :specific_item,
            12 => :limit_hold,
            13 => :recall,
            14 => :rush_recall,
            15 => :reloaning_limit,
            16 => :booking_permission,
            17 => :booking_hours
          }
          args[:hash_key] = :item_status
          super(args)
        end
      end
    end
  end
end