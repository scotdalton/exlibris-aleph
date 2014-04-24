module Exlibris
  module Aleph
    class Collections
      extend Forwardable
      def_delegators :all, :each, :[]

      include Singleton

      include Enumerable

      def all
        @all ||= begin
          Hash[
            admin_libraries.map do |admin_library|
              [admin_library, TableParser::Collections.new(admin_library).all]
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
