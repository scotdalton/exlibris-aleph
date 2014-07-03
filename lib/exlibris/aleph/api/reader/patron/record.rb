module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base
          class Record < Base

            attr_reader :hold_request, :short_loan, :ill, :booking_request,
              :acquisition_request

            def initialize(root)
              super(root)
              @hold_request = privilege_for_type('HoldRequest')
              @short_loan = privilege_for_type('ShortLoan')
              @ill = privilege_for_type('ILL')
              @booking_request = privilege_for_type('BookingRequest')
              @acquisition_request = privilege_for_type('AcquisitionRequest')
            end

            private
            def record
              @record ||= root['record']
            end

            def info
              @info ||= record['info']
            end

            def privilege_for_type(type)
              privilege = info.find { |element| element['type'] == type }
              privilege['allowed'] if privilege
            end
          end
        end
      end
    end
  end
end
