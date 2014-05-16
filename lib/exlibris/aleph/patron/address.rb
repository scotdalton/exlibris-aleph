module Exlibris
  module Aleph
    class Patron
      class Address
        attr_reader :patron_id
        (1..5).each do |n|
          attr_reader "address#{n}".to_sym
        end
        (1..4).each do |n|
          attr_reader "telephone#{n}".to_sym
        end
        attr_reader :zip, :sms_number, :want_sms, :email

        def initialize(patron_id)
          @patron_id = patron_id
          (1..5).each do |n|
            address_n = "address#{n}".to_sym
            instance_variable_set("@#{address_n}", reader.send(address_n))
          end
          (1..4).each do |n|
            telephone_n = "telephone#{n}".to_sym
            instance_variable_set("@#{telephone_n}", reader.send(telephone_n))
          end
          @zip = reader.zip
          @sms_number = reader.sms_number
          @want_sms = reader.want_sms
          @email = reader.email
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
