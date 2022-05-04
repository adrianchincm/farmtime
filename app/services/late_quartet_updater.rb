# frozen_string_literal: true

class LateQuartetUpdater < ApplicationService
  def initialize(portfolio)
    @portfolio = portfolio
  end
  
    def call
      url =
        "https://openapi.debank.com/v1/user/complex_protocol_list?id=#{@portfolio.fantom_address}&chain_id=ftm"
      getLateQuartet = HTTParty.get(url).parsed_response

      if (!getLateQuartet.empty? && getLateQuartet[0]["id"] == "ftm_beefy")
        lateQuarterValue = getLateQuartet[0]["portfolio_item_list"][0]["stats"]["asset_usd_value"]
        pool = Pool.find_by(portfolio_id: @portfolio.id, tokens: ["usd-coin", "fantom", "bitcoin", "ethereum"])
        pool.current_price = lateQuarterValue
        pool.save
      end          
      
    end
  end
  