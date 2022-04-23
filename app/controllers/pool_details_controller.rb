class PoolDetailsController < ApplicationController

    helper_method :get_total_pnl_amount

    def show        
        @chart_type = params[:chart] ||= "value"
        @portfolio_name = params[:name]
        @pool_id = params[:pool_id]
        portfolio = Portfolio.find_by(name: @portfolio_name)

        @pool = Pool.find_by(id: @pool_id, portfolio_id: portfolio.id) 
        @previous_daily = PreviousDailyProvider.call(@pool_id, portfolio.id)
        @previous_daily_pnl = get_percentage_pnl(@previous_daily).round(2)
        @previous_daily_pnl_amount = get_pnl_amount(@previous_daily).round(2)

        pool_dailies = PoolDaily.where(portfolio_id: portfolio.id, pool_id: @pool.id)
        pool_coindix_id = @pool.pool_stat.coindix_id
        pool_stat_dailies = PoolStatDaily.where(coindix_id: pool_coindix_id)

        @pool_price_hash = Hash.new
        @pool_apy_hash = Hash.new
        @pool_tvl_hash = Hash.new

        pool_dailies.each { |daily|
          @pool_price_hash[daily.created_at] = daily.current_price      
        }

        pool_stat_dailies.each { |daily|
            @pool_apy_hash[daily.created_at] = "#{daily.apy}%"
            @pool_tvl_hash[daily.created_at] = daily.tvl
        }
    
        @pool_stats = @pool.pool_stat
        
    end

    def get_percentage_pnl(previous_daily)
        ((@pool.current_price - previous_daily) / previous_daily) * 100
    end

    def get_pnl_amount(previous_daily)
        @pool.current_price - previous_daily
    end

    def get_total_pnl_amount
        @pool.current_price - @pool.initial_capital
    end
    
end
