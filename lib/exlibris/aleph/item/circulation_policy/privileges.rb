module Exlibris
  module Aleph
    module Item
      class CirculationPolicy
        class Privileges
          attr_reader :loanable, :renewable, :requestable, :photocopyable,
          :displayable, :specific_item, :limit_hold, :recallable,
          :rush_recallable, :reloaning_limit, :bookable, :booking_hours

          def initialize(row)
            @loanable = row.loanable
            @renewable = row.renewable
            @requestable = row.requestable
            @photocopyable = row.photocopyable
            @displayable = row.displayable
            @specific_item = row.specific_item
            @limit_hold = row.limit_hold
            @recallable = row.recallable
            @rush_recallable = row.rush_recallable
            @reloaning_limit = row.reloaning_limit
            @bookable = row.bookable
            @booking_hours = row.booking_hours
          end

          def loanable?
            loanable == 'Y'
          end

          def renewable?
            renewable == 'Y'
          end

          def requestable?
            always_requestable? || requestable == 'Y'
          end

          def always_requestable?
            requestable == 'C'
          end

          def photocopyable?
            photocopyable == 'Y'
          end

          def displayable?
            displayable == 'Y'
          end

          def specific_item?
            specific_item == 'Y'
          end

          def limit_hold?
            limit_hold == 'Y'
          end

          def recallable?
            recallable == 'Y'
          end

          def rush_recallable?
            rush_recallable == 'Y'
          end

          def bookable?
            bookable == 'Y'
          end
        end
      end
    end
  end
end
