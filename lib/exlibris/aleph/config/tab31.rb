module Exlibris
  module Aleph
    module Config
      class Tab31 < Exlibris::Aleph::Config::ConfigBySubLibrary

        def initialize(args)
          args[:aleph_file_name] = "tab31"
          args[:pattern] = /^(.{5})\s([0-9#]{2})\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([YN])\s([CF])\s([+A])\s([DMY\s])\s([0-9]{8})\s([0-9]{10})\s([YN])\s([YN])\s([YN])\s([0-9]{2})\s([YN])\s([YN])\s([YN])/
          args[:pattern_key] = {
            1  => :sub_library, 
            2  => :patron_status, 
            3  => :loan_permission, 
            4  => :photo_permission, 
            5  => :override_permission, 
            6  => :multiple_hold_permission,
            7  => :check_loan,
            8  => :hold_permission,
            9  => :renew_permission,
            10 => :ignore_late_return,
            11 => :photocopy_charge,
            12 => :expiration_date_operator,
            13 => :expiration_date_operator_type,
            14 => :expiration_date_parameter,
            15 => :cash_overspend_limit,
            16 => :hold_request_permission_for_item_on_shelf,
            17 => :loan_display,
            18 => :reading_room_permission,
            19 => :default_hold_priority,
            20 => :item_booking_permission,
            21 => :booking_ignore_closing_hours,
            22 => :automatically_create_aleph_record
          }
          args[:hash_key] = :patron_status
          super(args)
        end
      end
    end
  end
end