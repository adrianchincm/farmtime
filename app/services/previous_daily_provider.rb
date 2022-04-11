

# frozen_string_literal: true

class PreviousDailyProvider < ApplicationService
    def initialize(pool_id, portfolio_id)
        @pool_id = pool_id
        @portfolio_id = portfolio_id
      end
  
    def call
        pool_dailies = PoolDaily.where(pool_id: @pool_id, portfolio_id: @portfolio_id)

        if pool_dailies.last.created_at.to_date === Date.today
            previous_daily = pool_dailies[-2].current_price
        else
            previous_daily = pool_dailies.last.current_price
        end
                
        previous_daily
    end
  end
  