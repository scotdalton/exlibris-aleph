module Exlibris
  module Aleph
    module Table
      module Reader
        module Matcher
          class Base
            attr_reader :regexp, :string

            def initialize(regexp, string)
              @regexp = regexp
              @string = string
            end

            def match_data
              @match_data ||= regexp.match(string)
            end

            def matched_data
              @matched_data ||= match_data.captures
            end

            def matches?
              regexp === string
            end
          end
        end
      end
    end
  end
end
