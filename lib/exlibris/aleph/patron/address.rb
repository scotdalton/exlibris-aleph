module Exlibris
  module Aleph
    class Patron
      class Address
        attr_reader :patron_id

        def initialize(patron_id)
          @patron_id = patron_id
        end

        (1..5).each do |n|
          address_n = "address#{n}".to_sym
          define_method(address_n) do
            eval("@#{address_n} ||= reader.send(address_n)")
          end
        end

        (1..4).each do |n|
          telephone_n = "telephone#{n}".to_sym
          define_method(telephone_n) do
            eval("@#{telephone_n} ||= reader.send(telephone_n)")
          end
        end

        def zip
          @zip ||= reader.zip
        end

        def sms_number
          @sms_number ||= reader.sms_number
        end

        def want_sms
          @want_sms ||= reader.want_sms
        end

        def email
          @email ||= reader.email
        end

        private
        def client
          @client ||= API::Client::Patron::Address.new(patron_id)
        end

        def root
          @root ||= client.root
        end

        def reader
          @reader ||= API::Reader::Patron::Address.new(root)
        end
      end
    end
  end
end
