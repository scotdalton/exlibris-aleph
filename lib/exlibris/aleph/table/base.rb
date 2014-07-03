module Exlibris
  module Aleph
    module Table
      class Base

        extend Forwardable
        def_delegators :all, :each, :[]

        include Enumerable

        def all
          raise RuntimeError.new('Should be implmented in sub classes')
        end

        protected
        def admin_libraries
          @admin_libraries ||= Config.admin_libraries
        end
      end
    end
  end
end
