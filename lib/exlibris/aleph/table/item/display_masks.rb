module Exlibris
  module Aleph
    module Table
      module Item
        class DisplayMasks < Table::Base
          def all
            @all ||= begin
              Hash[
                admin_libraries.map do |admin_library|
                  [admin_library, Reader::ItemDisplayMasks.new(admin_library).all]
                end
              ]
            end
          end
        end
      end
    end
  end
end
