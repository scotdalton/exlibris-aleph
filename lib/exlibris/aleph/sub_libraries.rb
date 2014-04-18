module Exlibris
  module Aleph
    class SubLibraries
      extend Forwardable
      def_delegators :all, :each

      include Singleton

      include Enumerable

      def all
        @all ||= TableParser::SubLibraries.new.all
      end
    end
  end
end
