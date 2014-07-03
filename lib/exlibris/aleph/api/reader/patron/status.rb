module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base
          class Status < Base

            attr_reader :code, :display, :type, :expiration_date,
              :institution_code

            def initialize(root)
              super(root)
              @code = institution['z305_bor_status_code']
              @display = institution['z305_bor_status']
              @type = institution['z305_bor_type']
              @expiration_date = institution['z305_expiry_date']
              @institution_code = institution['code']
            end

            private
            def registration
              @registration ||= root['registration']
            end

            def institution
              @institution ||= registration['institution']
            end
          end
        end
      end
    end
  end
end
