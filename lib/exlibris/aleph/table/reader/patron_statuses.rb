module Exlibris
  module Aleph
    module Table
      module Reader
        class PatronStatuses < Base
          FILENAME = 'pc_tab_exp_field_extended.eng'

          def initialize(admin_library)
            super(admin_library, FILENAME)
          end

          def all
            rows.map { |row| Aleph::Patron::Status.new(row.code, row.display) }
          end
        end
      end
    end
  end
end
