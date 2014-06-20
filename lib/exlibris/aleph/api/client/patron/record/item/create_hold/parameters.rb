module Exlibris
  module Aleph
    module API
      module Client
        class Patron
          class Record
            class Item
              class CreateHold < Hold
                class Parameters
                  ROOT = 'hold-request-parameters'

                  attr_reader :pickup_location, :last_interest_date,
                    :start_interest_date, :sub_author, :sub_title, :pages,
                    :note_1, :note_2, :rush

                  def initialize(parameters)
                    unless parameters.is_a?(Hash)
                      raise ArgumentError.new("Expecting #{parameters} to be a Hash")
                    end
                    @pickup_location = parameters[:pickup_location]
                    unless pickup_location.nil? || pickup_location.is_a?(Exlibris::Aleph::PickupLocation)
                      raise ArgumentError.new("Expecting #{pickup_location} to be an Exlibris::Aleph::PickupLocation")
                    end
                    @last_interest_date = parameters[:last_interest_date]
                    @start_interest_date = parameters[:start_interest_date]
                    @sub_author = parameters[:sub_author]
                    @sub_title = parameters[:sub_title]
                    @pages = parameters[:pages]
                    @note_1 = parameters[:note_1]
                    @note_2 = parameters[:note_2]
                    @rush = parameters[:rush]
                  end

                  def to_xml
                    @xml ||= "<#{ROOT}>" +
                    "<pickup-location>#{pickup_location.code}</pickup-location>" +
                    "<last-interest-date>#{last_interest_date}</last-interest-date>" +
                    "<start-interest-date>#{start_interest_date}</start-interest-date>" +
                    "<sub-author>#{sub_author}</sub-author>" +
                    "<sub-title>#{sub_title}</sub-title>" +
                    "<pages>#{pages}</pages>" +
                    "<note-1>#{note_1}</note-1>" +
                    "<note-2>#{note_2}</note-2>" +
                    "<rush>#{rush}</rush>" +
                    "</#{ROOT}>"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
