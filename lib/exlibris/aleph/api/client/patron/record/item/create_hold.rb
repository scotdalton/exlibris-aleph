module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            class Item
              class CreateHold < Hold
                attr_reader :parameters

                def initialize(*args, parameters)
                  unless parameters.is_a?(Parameters)
                    raise ArgumentError.new("Expecting #{parameters} to be a Parameters")
                  end
                  @parameters = parameters
                  @request_method = :put
                  super(*args)
                end

                private
                def put
                  connection.put(path, "post_xml=#{parameters.to_xml}")
                end
              end
            end
          end
        end
      end
    end
  end
end
