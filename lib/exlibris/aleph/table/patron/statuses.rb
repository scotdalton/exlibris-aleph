module Exlibris
  module Aleph
    module Table
      module Patron
        class Statuses < Table::Base
          def all
            @all ||= begin
              Hash[
                admin_libraries.map do |admin_library|
                  [admin_library, Reader::PatronStatuses.new(admin_library).all]
                end
              ]
            end
          end
        end
      end
    end
  end
end
