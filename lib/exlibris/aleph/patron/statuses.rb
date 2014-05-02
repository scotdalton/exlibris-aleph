module Exlibris
  module Aleph
    class Patron
      class Statuses
        extend Forwardable
        def_delegators :all, :each, :[]

        include Singleton

        include Enumerable

        def all
          @all ||= begin
            Hash[
              admin_libraries.map do |admin_library|
                [admin_library, TableParser::PatronStatuses.new(admin_library).all]
              end
            ]
          end
        end

        private
        def admin_libraries
          @admin_libraries ||= Config.admin_libraries
        end
      end
    end
  end
end
