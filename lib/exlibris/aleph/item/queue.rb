module Exlibris
  module Aleph
    class Item
      class Queue
        attr_reader :value

        def initialize(value)
          @value = value
        end

        def to_s
          value
        end

        def number_of_requests
          @number_of_requests ||= begin
            if number_of_requests_matched_data.nil?
              0
            else
              number_of_requests_matched_data[1].to_i
            end
          end
        end

        private
        def number_of_requests_matched_data
          @number_of_requests_matched_data ||= /^(\d+) request\(s\)/.match(value)
        end
      end
    end
  end
end
