module Exlibris
  module Aleph
    module Table
      module Reader
        class Base
          attr_reader :admin_library, :filename

          def initialize(admin_library, filename)
            @admin_library = admin_library
            @filename = filename
          end

          def all
            raise RuntimeError.new('Should be implmented in sub classes')
          end

          protected
          def rows
            @rows ||= file.map do |line|
              matcher = matcher_constant.new(line)
              row_contant.new(matcher.matched_data) if matcher.matches?
            end.compact
          end

          private
          def file
            @file ||= File.new(absolute_path)
          end

          def absolute_path
            @absolute_path ||= "#{table_path}/#{relative_path}/#{filename}"
          end

          def relative_path
            @relative_path ||= "#{admin_library.normalized_code}/tab"
          end

          def table_path
            @table_path ||= Config.table_path
          end

          def matcher_constant
            eval("Matcher::#{demodulized_class_name}")
          end

          def row_contant
            eval("Row::#{demodulized_class_name}")
          end

          def demodulized_class_name
            @demodulized_class_name ||= self.class.name.split('::').last
          end
        end
      end
    end
  end
end
