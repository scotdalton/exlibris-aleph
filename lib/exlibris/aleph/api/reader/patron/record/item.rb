module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base
          class Record < Base
            class Item < Base

              attr_reader :hold_request, :short_loan, :photocopy_request,
                :booking_request

              def initialize(root)
                super(root)
                @hold_request = privilege_for_type('HoldRequest')
                @short_loan = privilege_for_type('ShortLoan')
                @photocopy_request = privilege_for_type('PhotocopyRequest')
                @booking_request = privilege_for_type('BookingRequest')
              end

              def pickup_locations
                @pickup_locations ||= pickup_location.map do |location|
                  code = location['code']
                  display = location['__content__']
                  PickupLocation.new(code, display)
                end
              end

              private
              def item
                @item ||= root['item']
              end

              def info
                @info ||= item['info']
              end

              def hold_request_root
                @hold_request_root ||= info.find do |element|
                  element['type'] == 'HoldRequest'
                end
              end

              def hold
                @hold ||= hold_request_root['hold']
              end

              def pickup_locations_root
                unless hold.nil?
                  @pickup_locations_root ||= hold['pickup_locations']
                end
              end

              def pickup_location
                @pickup_location ||= begin
                  if pickup_locations_root.nil?
                    []
                  elsif pickup_locations_root['pickup_location'].nil?
                    []
                  elsif pickup_locations_root['pickup_location'].is_a?(Hash)
                    [pickup_locations_root['pickup_location']]
                  else
                    pickup_locations_root['pickup_location']
                  end
                end
              end

              def privilege_for_type(type)
                privilege = info.find { |element| element['type'] == type }
                privilege['allowed'] if privilege
              end
            end
          end
        end
      end
    end
  end
end
