module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base
          class Record < Base
            class Item < Base
              class CreateHold < Base

                attr_reader :note, :type

                def initialize(root)
                  super(root)
                  @note = note_root['__content__']
                  @type = note_root['type']
                end

                private
                def create_hold
                  @create_hold ||= root['create_hold']
                end

                def note_root
                  @note_root ||= create_hold['note']
                end
              end
            end
          end
        end
      end
    end
  end
end