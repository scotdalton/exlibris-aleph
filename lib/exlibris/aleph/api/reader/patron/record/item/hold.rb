module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base
          class Record < Base
            class Item < Base
              class Hold < Base

                attr_reader :allowed

                def initialize(root)
                  super(root)
                  @allowed = hold['allowed']
                end

                def pickup_locations
                  @pickup_locations ||= pickup_location.map do |location|
                    code = location['code']
                    display = location['__content__']
                    PickupLocation.new(code, display)
                  end
                end

                private
                def hold
                  @hold ||= root['hold']
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
              end
            end
          end
        end
      end
    end
  end
end