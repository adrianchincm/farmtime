class PortfolioController < ApplicationController
    def show
        portfolio_name = params[:name]
        @portfolio = Portfolio.find_by(name: portfolio_name)
        
        @pools = Pool.where(portfolio_id: @portfolio.id).sort_by(&:pool_owner)
        @portfolio_total = @pools.sum(&:current_price)
    end
end
