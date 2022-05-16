class PortfolioController < ApplicationController
    def show
        portfolio_name = params[:name]
        @portfolio = Portfolio.find_by(name: portfolio_name)
        
        all_pools = Pool.where(portfolio_id: @portfolio.id).sort_by(&:pool_owner)
        @pools = all_pools.select{ |pool| pool[:is_active] }
        @inactive_pools = all_pools.select{ |pool| !pool[:is_active] }
        @portfolio_total = @pools.sum(&:current_price)
    end
end
