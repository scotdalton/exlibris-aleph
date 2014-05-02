module Exlibris
  module Aleph
    module TableParser
      class PatronCirculationPolicies < Base
        FILENAME = 'tab31'

        def initialize(admin_library)
          super(admin_library, FILENAME)
        end

        def all
          rows.map do |row|
            sub_library = sub_libraries.find do |sub_library|
              sub_library.code == row.sub_library_code
            end
            unless sub_library.nil?
              status = patron_statuses[admin_library].find do |patron_status|
                patron_status.code == row.patron_status_code
              end
              if status.nil? && row.patron_status_code == '##'
                status = Patron::GenericStatus.new
              end
              unless status.nil? 
                identifier =
                  Patron::CirculationPolicy::Identifier.new(status, sub_library)
                privileges =
                  Patron::CirculationPolicy::Privileges.new(row)
                Patron::CirculationPolicy.new(identifier, privileges)
              end
            end
          end.compact
        end

        private
        def sub_libraries
          @sub_libraries ||= Exlibris::Aleph::SubLibraries.instance
        end

        def patron_statuses
          @patron_statuses ||= Exlibris::Aleph::Patron::Statuses.instance
        end
      end
    end
  end
end
