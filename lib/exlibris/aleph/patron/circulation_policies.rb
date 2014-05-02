module Exlibris
  module Aleph
    class Patron
      class CirculationPolicies
        extend Forwardable
        def_delegators :all, :each

        include Singleton

        include Enumerable

        def all
          @all ||= begin
            Hash[
              admin_libraries.map do |admin_library|
                [admin_library, TableParser::PatronCirculationPolicies.new(admin_library).all]
              end
            ]
          end
        end

        def find_by_identifier(identifier)
          unless identifier.is_a?(CirculationPolicy::Identifier)
            raise ArgumentError.new("Expecting #{identifier} to be a CirculationPolicy::Identifier")
          end
          sub_library = identifier.sub_library
          circulation_policy = _find_by_identifier(identifier)
          # Try with a "generic" patron status
          if circulation_policy.nil?
            generic_status_identifier =
              CirculationPolicy::Identifier.new(generic_status, sub_library)
            circulation_policy = _find_by_identifier(generic_status_identifier)
          end
          circulation_policy
        end

        private
        def admin_libraries
          @admin_libraries ||= Config.admin_libraries
        end

        def generic_status
          @generic_status ||= GenericStatus.new
        end

        def _find_by_identifier(identifier)
          sub_library = identifier.sub_library
          admin_library = sub_library.admin_library
          all[admin_library].find do |circulation_policy|
            circulation_policy.identifier == identifier
          end
        end
      end
    end
  end
end
