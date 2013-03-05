module Exlibris
  module Aleph
    module Xservice
      require 'open-uri'
      require 'nokogiri'
      # ==Overview
      # Exlibris::Aleph::BorAuth provides access to the BorAuth Aleph XService.
      class BorAuth
        attr_reader :response, :error, :session_id
      
        # Creates an instance of Exlibris::Aleph::BorAuth based on the input parameters.
        def initialize(aleph_url, library, sub_library, translate, bor_id, bor_verification)
          url = "#{aleph_url}/X?"
          url += "op=bor-auth&library=#{library}&"
          url += "sub_library=#{sub_library}&translate=#{translate}&"
          url += "bor_id=#{bor_id}&verification=#{bor_verification}&"
          @response = Nokogiri.XML(open(url))
          @session_id = @response.at("//session-id").inner_text unless @response.at("//session-id").nil?
          @error = @response.at("//error").inner_text unless @response.at("//error").nil?
        end
      
        # Returns a Hash of permissions for the Aleph sub library passed into the constructor.
        def permissions
          rv = {}
          return rv unless @response and self.error.nil?
          rv[:home_sub_library] = @response.at("z303-home-library").inner_text unless @response.at("z303-home-library").nil?
          rv[:bor_status] = @response.at("z305-bor-status").inner_text unless @response.at("z305-bor-status").nil?
          rv[:bor_type] = @response.at("z305-bor-type").inner_text unless @response.at("z305-bor-type").nil?
          rv[:loan_permission] = @response.at("z305-loan-permission").inner_text unless @response.at("z305-loan-permission").nil?
          rv[:photo_permission] = @response.at("z305-photo-permission").inner_text unless @response.at("z305-photo-permission").nil?
          rv[:over_permission] = @response.at("z305-over-permission").inner_text unless @response.at("z305-over-permission").nil?
          rv[:multi_hold] = @response.at("z305-multi-hold").inner_text unless @response.at("z305-multi-hold").nil?
          rv[:loan_check] = @response.at("z305-loan-check").inner_text unless @response.at("z305-loan-check").nil?
          rv[:hold_permission] = @response.at("z305-hold-permission").inner_text unless @response.at("z305-hold-permission").nil?
          rv[:renew_permission] = @response.at("z305-renew-permission").inner_text unless @response.at("z305-renew-permission").nil?
          rv[:rr_permission] = @response.at("z305-rr-permission").inner_text unless @response.at("z305-rr-permission").nil?
          rv[:ignore_late_return] = @response.at("z305-ignore-late-return").inner_text unless @response.at("z305-ignore-late-return").nil?
          rv[:hold_on_shelf] = @response.at("z305-hold-on-shelf").inner_text unless @response.at("z305-hold-on-shelf").nil?
          rv[:end_block_date] = @response.at("z305-end-block-date").inner_text unless @response.at("z305-end-block-date").nil?
          rv[:booking_permission] = @response.at("z305-booking-permission").inner_text unless @response.at("z305-booking-permission").nil?
          rv[:booking_ignore_hours] = @response.at("z305-booking-ignore-hours").inner_text unless @response.at("z305-booking-ignore-hours").nil?
          return rv
        end
      end
    end
  end
end