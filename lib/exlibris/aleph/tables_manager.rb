module Exlibris
  module Aleph
    require 'singleton'
    class TablesManager

      # Number of seconds before the table is
      # considered expired, 86400 seconds is 1 day
      TIME_TO_LIVE = 86400

      include Singleton

      def expired?
        Time.now > expiration_date
      end

      def sub_libraries
        reset! if expired?
        @sub_libraries ||= Table::SubLibraries.new
      end

      def collections
        reset! if expired?
        @collections ||= Table::Collections.new
      end

      def patron_statuses
        reset! if expired?
        @patron_statuses ||= Table::Patron::Statuses.new
      end

      def patron_circulation_policies
        reset! if expired?
        @patron_circulation_policies ||= Table::Patron::CirculationPolicies.new
      end

      def item_circulation_policies
        reset! if expired?
        @item_circulation_policies ||= Table::Item::CirculationPolicies.new
      end

      def item_display_masks
        reset! if expired?
        @item_display_masks ||= Table::Item::DisplayMasks.new
      end

      private
      def initialize
        expiration_date
      end

      def expiration_date
        @expiration_date ||= Time.now + TIME_TO_LIVE
      end

      def reset!
        @expiration_date = nil
        @sub_libraries = nil
        @collections = nil
        @patron_statuses = nil
        @patron_circulation_policies = nil
        @item_circulation_policies = nil
        @item_display_masks = nil
      end
    end
  end
end
