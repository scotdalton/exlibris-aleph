module Exlibris
  module Aleph
    module TableParser
      module Row
        class Base
          def self.attr_ordered_keys(*ordered_keys)
            ordered_keys.each_with_index do |key, index|
              define_method(key) do
                eval("@#{key} ||= data[#{index}].strip")
              end
            end
          end

          attr_reader :data

          def initialize(data)
            @data = data
          end
        end
      end
    end
  end
end
