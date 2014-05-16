module Exlibris
  module Aleph
    module API
      module Reader
        class Patron < Base
          class Address < Base

            attr_reader :address1, :address2, :address3, :address4, :address5,
              :telephone1, :telephone2, :telephone3, :telephone4, :zip,
              :sms_number, :want_sms, :email

            def initialize(root)
              super(root)
              @address1 = z304_address_1['__content__']
              @address2 = z304_address_2['__content__']
              @address3 = z304_address_3['__content__']
              @address4 = z304_address_4['__content__']
              @address5 = z304_address_5['__content__']
              @telephone1 = z304_telephone_1['__content__']
              @telephone2 = z304_telephone_2['__content__']
              @telephone3 = z304_telephone_3['__content__']
              @telephone4 = z304_telephone_4['__content__']
              @zip = z304_zip['__content__']
              @sms_number = z304_sms_number['__content__']
              @want_sms = z303_want_sms['__content__']
              @email = z304_email_address['__content__']
            end

            private
            def address
              @address ||= root['address_information']
            end

            def z304_address_1
              @z304_address_1 ||= address['z304_address_1']
            end

            def z304_address_2
              @z304_address_2 ||= address['z304_address_2']
            end

            def z304_address_3
              @z304_address_3 ||= address['z304_address_3']
            end

            def z304_address_4
              @z304_address_4 ||= address['z304_address_4']
            end

            def z304_address_5
              @z304_address_5 ||= address['z304_address_5']
            end

            def z304_telephone_1
              @z304_telephone_1 ||= address['z304_telephone_1']
            end

            def z304_telephone_2
              @z304_telephone_2 ||= address['z304_telephone_2']
            end

            def z304_telephone_3
              @z304_telephone_3 ||= address['z304_telephone_3']
            end

            def z304_telephone_4
              @z304_telephone_4 ||= address['z304_telephone_4']
            end

            def z304_zip
              @z304_zip ||= address['z304_zip']
            end

            def z304_sms_number
              @z304_sms_number ||= address['z304_sms_number']
            end

            def z303_want_sms
              @z303_want_sms ||= address['z303_want_sms']
            end

            def z304_email_address
              @z304_email_address ||= address['z304_email_address']
            end
          end
        end
      end
    end
  end
end
