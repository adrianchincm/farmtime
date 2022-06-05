class PortfolioController < ApplicationController
    def show
        portfolio_name = params[:name]
        @portfolio = Portfolio.find_by(name: portfolio_name)
        
        all_pools = Pool.where(portfolio_id: @portfolio.id).sort_by(&:pool_owner)
        @pools = all_pools.select{ |pool| pool[:is_active] }
        @inactive_pools = all_pools.select{ |pool| !pool[:is_active] }
        @farm_total = @pools.sum(&:current_price)
        @wallet = Wallet.find_by(portfolio_id: @portfolio.id, wallet_type: "Binance")
        @wallet_total = get_total_amount_in_usd(@wallet)
        @portfolio_total = @wallet_total + @farm_total        
    end

    private 

    def get_total_amount_in_usd(wallet)
        total_amount = 0
        @wallet.tokens.each do |token|
            total_amount += token.amount * token.coin.price
        end
        total_amount
    end
end
