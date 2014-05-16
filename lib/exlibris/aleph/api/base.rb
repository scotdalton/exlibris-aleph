module Exlibris
  module Aleph
    module API
      class Base
        extend Forwardable

        protected
        def client
          raise RuntimeError.new('Should be implmented in sub classes')
        end

        def reader
          @reader ||= reader_constant.new(client.root)
        end

        private
        def reader_constant
          eval("Reader::#{demodulized_class_name}")
        end

        def demodulized_class_name
          @demodulized_class_name ||= self.class.name.split('::').last
        end
      end
    end
  end
end
