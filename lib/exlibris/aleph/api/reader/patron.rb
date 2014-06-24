module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base

          def admin_library_code
            @admin_library_code ||= patron['translate_change_active_library'] unless patron.nil?
          end

          private
          def patron
            @patron ||= root['patron']
          end
        end
      end
    end
  end
end
