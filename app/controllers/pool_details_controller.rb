class PoolDetailsController < ApplicationController
    def show
        @portfolio_name = params[:portfolio_name]
        @pool_id = params[:pool_id]
        portfolio = Portfolio.find_by(name: @portfolio_name)

        @pool = Pool.find_by(id: @pool_id, portfolio_id: portfolio.id) 
        @previous_daily = PreviousDailyProvider.call(@pool_id, portfolio.id)
        @previous_daily_pnl = get_percentage_pnl(@previous_daily).round(2)
        @previous_daily_pnl_amount = get_pnl_amount(@previous_daily).round(2)
    end

    def get_percentage_pnl(previous_daily)
        ((@pool.current_price - previous_daily) / previous_daily) * 100
    end

    def get_pnl_amount(previous_daily)
        @pool.current_price - previous_daily
    end
    
end
