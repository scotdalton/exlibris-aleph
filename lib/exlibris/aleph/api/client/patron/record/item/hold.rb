module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            class Item
              class Hold < Base
                attr_reader :patron_id, :record_id, :item_id, :parameters

                def initialize(patron_id, record_id, item_id, parameters=nil)
                  @patron_id = patron_id
                  @record_id = record_id
                  @item_id = item_id
                  unless parameters.nil?
                    unless parameters.is_a?(Parameters)
                      raise ArgumentError.new("Expecting #{parameters} to be a Parameters")
                    end
                    @parameters = parameters
                    @request_method = :put
                  end
                end

                protected
                def path
                  @path ||=
                    "#{super}/patron/#{patron_id}/record/#{record_id}/items/#{item_id}/hold"
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
