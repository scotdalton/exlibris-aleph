module Exlibris
  module Aleph
    module Item
      class DisplayMasks
        extend Forwardable
        def_delegators :all, :each, :[]

        include Singleton

        include Enumerable

        def all
          @all ||= begin
            Hash[
              admin_libraries.map do |admin_library|
                [admin_library, TableParser::ItemDisplayMasks.new(admin_library).all]
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
