# frozen_string_literal: true

class LateQuartetUpdater < ApplicationService
  def initialize(address)
    @address = address
  end
  
    def call
      url =
        "https://openapi.debank.com/v1/user/complex_protocol_list?id=#{@address}&chain_id=ftm"
      getLateQuartet = HTTParty.get(url).parsed_response

      if (getLateQuartet[0]["id"] == "ftm_beefy")
        lateQuarterValue = getLateQuartet[0]["portfolio_item_list"][0]["stats"]["asset_usd_value"]
        pool = Pool.find_by(tokens: ["fantom", "bitcoin", "ethereum", "usd-coin"])
        pool.current_price = lateQuarterValue
        pool.save
      end          
      
    end
  end
  