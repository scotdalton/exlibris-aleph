module Exlibris
  module Aleph
    module Table
      module Item
        class CirculationPolicies < Table::Base
          def all
            @all ||= begin
              Hash[
                admin_libraries.map do |admin_library|
                  [admin_library, Reader::ItemCirculationPolicies.new(admin_library).all]
                end
              ]
            end
          end

          def find_by_identifier(identifier)
            unless identifier.is_a?(Aleph::Item::CirculationPolicy::Identifier)
              raise ArgumentError.new("Expecting #{identifier} to be a CirculationPolicy::Identifier")
            end
            sub_library = identifier.sub_library
            circulation_policy = _find_by_identifier(identifier)
            # Try with a "generic" item status
            if circulation_policy.nil?
              processing_status = identifier.processing_status
              generic_status_identifier =
                Aleph::Item::CirculationPolicy::Identifier.new(generic_status, processing_status, sub_library)
              circulation_policy = _find_by_identifier(generic_status_identifier)
            end
            # Try with a "generic" item processing status
            if circulation_policy.nil?
              status = identifier.status
              generic_processing_status_identifier =
                Aleph::Item::CirculationPolicy::Identifier.new(status, generic_processing_status, sub_library)
              circulation_policy = _find_by_identifier(generic_processing_status_identifier)
            end
            # Try with both a "generic" item status AND a "generic" item processing status
            if circulation_policy.nil?
              generic_identifier =
                Aleph::Item::CirculationPolicy::Identifier.new(generic_status, generic_processing_status, sub_library)
              circulation_policy = _find_by_identifier(generic_identifier)
            end
            circulation_policy
          end

          private
          def generic_status
            @generic_status ||= Aleph::Item::Status.new('##')
          end

          def generic_processing_status
            @generic_processing_status ||= Aleph::Item::ProcessingStatus.new('##')
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
end
